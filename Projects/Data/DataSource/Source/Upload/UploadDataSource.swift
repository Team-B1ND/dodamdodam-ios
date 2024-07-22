//
//  UploadDataSource.swift
//  DodamDodam
//
//  Created by Mercen on 3/28/24.
//

import Network
import Domain
import Foundation
import SwiftBok

@Init()
public struct UploadDataSource: DataSourceProtocol {
    
    let remote: UploadRemote
    
    public func postUpload(data: Data) async throws -> UploadResponse {
        let response = try await remote.postUpload(data: data)
        return response.data
    }
}
