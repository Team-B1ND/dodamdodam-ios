//
//  RemoteInterceptor.swift
//  DodamDodam
//
//  Created by Mercen on 3/31/24.
//

import Foundation
import Alamofire
import SignKit

class RemoteInterceptor: RequestInterceptor {
    
    func retry(
        _ request: Request,
        for session: Session,
        dueTo error: Error,
        completion: @escaping (RetryResult) -> Void
    ) {
        guard let response = request.task?.response as? HTTPURLResponse,
              response.statusCode == 401 else {
            completion(.doNotRetryWithError(error))
            return
        }
        
        guard let refreshToken = Sign.refreshToken else {
            completion(.doNotRetryWithError(error))
            return
        }
        
        @Inject var authRepository: any AuthRepository
        
        Task {
            do {
                try await authRepository.postReissue(
                    .init(refreshToken: refreshToken)
                )
                completion(.retry)
//                DispatchQueue.main.async {
//                    completion(.retry)
//                }
            } catch {
                if let id = Sign.id,
                   let pw = Sign.password {
                    do {
                        _ = try await authRepository.postLogin(
                            .init(id: id, pw: pw)
                        )
                        completion(.retry)
//                        DispatchQueue.main.async {
//                            completion(.retry)
//                        }
                    } catch let error {
                        DispatchQueue.main.async {
                            completion(.doNotRetryWithError(error))
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(.doNotRetryWithError(error))
                    }
                }
            }
        }
    }
}
