//
//  UploadRemote.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

import Foundation
import Domain

public struct UploadRemote: RemoteProtocol {
    
    typealias Target = UploadService
    
    public init() {}
    
    public func postUpload(data: Data) async throws -> Response<UploadResponse> {
        try await self.request(target: .postUpload(data: data), res: UploadResponse.self)
    }
}
