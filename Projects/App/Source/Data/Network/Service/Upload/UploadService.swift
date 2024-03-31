//
//  UploadService.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

import Foundation
import Moya

enum UploadService: ServiceProtocol {
    
    case postUpload(data: Data)
}

extension UploadService {
    
    var host: String {
        "upload"
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
        case let .postUpload(data):
            let formData = MultipartFormData(
                provider: .data(data),
                name: UUID().uuidString
            )
            return .uploadMultipart([formData])
        }
    }
}
