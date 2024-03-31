//
//  RemoteInterceptor.swift
//  DodamDodam
//
//  Created by Mercen on 3/31/24.
//

import Foundation
import Alamofire
import SignKit

struct RemoteInterceptor: RequestInterceptor {
    
    func retry(
        _ request: Request,
        for session: Session,
        dueTo error: Error,
        completion: @escaping (RetryResult) -> Void
    ) async {
        guard let response = request.task?.response as? HTTPURLResponse,
              response.statusCode == 401 else {
            completion(.doNotRetryWithError(error))
            return
        }
        if let refreshToken = Sign.refreshToken {
            @Inject var authRepository: any AuthRepository
            do {
                try await authRepository.postReissue(
                    .init(refreshToken: refreshToken)
                )
                completion(.retry)
            } catch {
                if let id = Sign.id,
                   let pw = Sign.password {
                    do {
                        _ = try await authRepository.postLogin(
                            .init(id: id, pw: pw)
                        )
                    } catch let error {
                        completion(.doNotRetryWithError(error))
                    }
                }
            }
        } else {
            completion(.doNotRetryWithError(error))
        }
    }
}
