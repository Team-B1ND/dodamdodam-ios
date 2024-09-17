//
//  UploadRepositoryImpl.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

import Foundation
import Domain
import DataSource

public struct UploadRepositoryImpl: UploadRepository {
    
    let dataSource: UploadDataSource
    
    public init(dataSource: UploadDataSource) {
        self.dataSource = dataSource
    }
    
    public func postUpload(data: Data) async throws -> UploadResponse {
        try await dataSource.postUpload(data: data)
    }
}
