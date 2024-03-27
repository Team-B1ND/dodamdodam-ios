//
//  UploadService.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

import Foundation
import Moya

enum UploadService: ServiceProtocol {
    
    case postUpload(_ file: Data)
}

extension UploadService {
    
    var baseURL: URL {
        host.appendingPathComponent("upload")
    }
    
    var path: String {
        switch self {
        case .postUpload: ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postUpload: .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case let .postUpload(file):
            let data = MultipartFormData(
                provider: .data(file),
                name: UUID().uuidString
            )
            return .uploadMultipart([data])
        }
    }
}
