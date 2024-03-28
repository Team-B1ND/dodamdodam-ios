//
//  UploadRepositoryImpl.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

import Foundation

struct UploadRepositoryImpl: UploadRepository {
    
    let dataSource: UploadDataSource
    
    func postUpload(data: Data) async throws -> UploadResponse {
        try await dataSource.postUpload(data: data)
    }
}
