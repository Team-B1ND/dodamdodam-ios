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
    
    private let maxRetryCount = 3
    private var retryCount = 0
    
    func retry(
        _ request: Request,
        for session: Session,
        dueTo error: Error,
        completion: @escaping (RetryResult) -> Void
    ) {
        guard retryCount < maxRetryCount else {
            completion(.doNotRetryWithError(error))
            return
        }
        
        guard let response = request.task?.response as? HTTPURLResponse else {
            completion(.doNotRetryWithError(error))
            return
        }
        
        if response.statusCode == 200 {
            completion(.doNotRetry)
            return
        }
        
        guard response.statusCode == 401, let refreshToken = Sign.refreshToken else {
            completion(.doNotRetryWithError(error))
            return
        }
        
        @Inject var authRepository: any AuthRepository
        
        Task {
            do {
                try await authRepository.postReissue(
                    .init(refreshToken: refreshToken)
                )
                DispatchQueue.main.async {
                    self.retryCount += 1
                    completion(.retry)
                }
            } catch {
                if let id = Sign.id,
                   let pw = Sign.password {
                    do {
                        _ = try await authRepository.postLogin(
                            .init(id: id, pw: pw)
                        )
                        DispatchQueue.main.async {
                            self.retryCount += 1
                            completion(.retry)
                        }
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
