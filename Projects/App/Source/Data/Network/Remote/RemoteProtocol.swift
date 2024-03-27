//
//  RemoteProtocol.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Foundation
import Moya

protocol RemoteProtocol {
    
    associatedtype Target: TargetType
    
    var provider: MoyaProvider<Target> { get }
    
    var decoder: JSONDecoder { get }
    
    func request(
        target: MoyaProvider<Target>.Target
    ) async throws -> Moya.Response
}

extension RemoteProtocol {
    
    var provider: MoyaProvider<Target> {
        .init(plugins: [NetworkLoggerPlugin()])
    }
    
    var decoder: JSONDecoder {
        .init()
    }
    
    func request(
        target: MoyaProvider<Target>.Target
    ) async throws -> Moya.Response {
        try await withUnsafeThrowingContinuation { continuation in
            provider.request(target) { result in
                switch result {
                case let .success(data):
                    continuation.resume(returning: data)
                case let .failure(error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
