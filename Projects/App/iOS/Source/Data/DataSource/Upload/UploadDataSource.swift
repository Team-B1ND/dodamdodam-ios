//
//  UploadDataSource.swift
//  DodamDodam
//
//  Created by Mercen on 3/28/24.
//

import Foundation

struct UploadDataSource: DataSourceProtocol {
    
    let remote: UploadRemote
    
    func postUpload(data: Data) async throws -> UploadResponse {
        let response = try await remote.postUpload(data: data)
        return response.data
    }
}
