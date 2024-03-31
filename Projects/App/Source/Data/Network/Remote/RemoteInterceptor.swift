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
            await refresh(refreshToken: refreshToken, dueTo: error) {
                completion($0)
            }
        } else {
            completion(.doNotRetryWithError(error))
        }
    }
}
