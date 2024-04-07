//
//  UploadRepository.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

import Foundation

protocol UploadRepository: RepositoryProtocol {
    
    func postUpload(data: Data) async throws -> UploadResponse
}
