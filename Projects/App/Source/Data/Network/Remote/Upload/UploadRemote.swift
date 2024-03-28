//
//  UploadRemote.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

import Foundation

struct UploadRemote: RemoteProtocol {
    
    typealias Target = UploadService
    
    func postUpload(data: Data) async throws -> Response<UploadResponse> {
        try await self.request(target: .postUpload(data: data))
            .map(Response<UploadResponse>.self, using: decoder)
    }
}
