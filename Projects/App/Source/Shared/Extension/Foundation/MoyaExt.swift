//
//  MoyaExt.swift
//  DodamDodam
//
//  Created by Mercen on 3/12/24.
//

import Moya

public extension MoyaProvider {
    
    func request(_ target: Target) async -> Result<Response, MoyaError> {
        await withCheckedContinuation { continuation in
            request(target) {
                continuation.resume(returning: $0)
            }
        }
    }
}
