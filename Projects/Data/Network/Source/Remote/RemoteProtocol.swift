//
//  RemoteProtocol.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Foundation
import Moya
import SignKit
import Domain
import Shared

protocol RemoteProtocol {
    
    associatedtype Target: TargetType
    
    var provider: MoyaProvider<Target> { get }
    
    var decoder: JSONDecoder { get }
    
    func request<D: ResponseProtocol>(
        target: MoyaProvider<Target>.Target,
        res: D.Type
    ) async throws -> Domain.Response<D>
    
    func request(
        target: MoyaProvider<Target>.Target
    ) async throws -> DefaultResponse
}

extension RemoteProtocol {
    
    var provider: MoyaProvider<Target> {
        .init(
            session: Moya.Session(interceptor: RemoteInterceptor()),
            plugins: [NetworkLoggerPlugin(
                configuration: .init(
                    logOptions: .verbose
                )
            )]
        )
    }
    
    var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let dateStr = try container.decode(String.self)
            let dateFormatters = DateFormatterType.allCases
            if let date = dateFormatters.compactMap({ DateFormatter(type: $0).date(from: dateStr) }).first {
                return date
            } else {
                let context = DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Invalid date format")
                throw DecodingError.dataCorrupted(context)
            }
        }
        return decoder
    }
    
    private func request(
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
    
    func request<D: ResponseProtocol>(
        target: MoyaProvider<Target>.Target,
        res: D.Type
    ) async throws -> Domain.Response<D> {
        try await self.request(target: target)
            .map(Response<D>.self, using: decoder)
    }
    
    func request(
        target: MoyaProvider<Target>.Target
    ) async throws -> DefaultResponse {
        try await self.request(target: target)
            .map(DefaultResponse.self, using: decoder)
    }
}
