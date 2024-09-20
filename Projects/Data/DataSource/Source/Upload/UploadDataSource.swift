//
//  UploadDataSource.swift
//  DodamDodam
//
//  Created by Mercen on 3/28/24.
//

import Network
import Domain
import Foundation

public struct UploadDataSource: DataSourceProtocol {
    let remote: UploadRemote
    
    public init(remote: UploadRemote) {
        self.remote = remote
    }
    
    public func postUpload(data: Data) async throws -> UploadResponse {
        let response = try await remote.postUpload(data: data)
        return response.data
    }
}
