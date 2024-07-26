//
//  RemoteInterceptor.swift
//  DodamDodam
//
//  Created by Mercen on 3/31/24.
//

import Foundation
import Alamofire
import SignKit
import Domain
import Shared
import DIContainer

class RemoteInterceptor: RequestInterceptor {
    
    private let notReissuePaths = [
        "reissue",
        "login"
    ]
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, any Error>) -> Void) {
        guard let accessToken = Sign.accessToken else {
            completion(.success(urlRequest))
            return
        }
        
        for path in notReissuePaths {
            if urlRequest.url?.absoluteString.contains(path) ?? true {
                completion(.success(urlRequest))
                return
            }
        }
        var modifiedRequest = urlRequest
        modifiedRequest.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        completion(.success(modifiedRequest))
    }

    func retry(
        _ request: Request,
        for session: Session,
        dueTo error: Error,
        completion: @escaping (RetryResult) -> Void
    ) {
        guard let response = request.task?.response as? HTTPURLResponse else {
            completion(.doNotRetryWithError(error))
            return
        }
        
        guard request.retryCount <= 3 else {
            print("❌ RemoteInterceptor - RetryCount가 3보다 큽니다")
            return
        }
        
        if response.statusCode == 200 {
            completion(.doNotRetry)
            return
        }
        
        print(response.statusCode)
        
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
                completion(.retry)
            } catch {
                if let id = Sign.id,
                   let pw = Sign.password {
                    do {
                        _ = try await authRepository.postLogin(
                            .init(id: id, pw: pw)
                        )
                        DispatchQueue.main.async {
//                            self.retryCount += 1
                            completion(.retry)
                        }
                    } catch let error {
                        DispatchQueue.main.async {
                            completion(.doNotRetryWithError(error))
                        }
                    }
                } else {
                    print("22 \(error)")
                    DispatchQueue.main.async {
                        completion(.doNotRetryWithError(error))
                    }
                }
            }
        }
    }
}
