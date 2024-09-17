//
//  AllowStatus.swift
//  DodamDodam
//
//  Created by Mercen on 3/28/24.
//

import Foundation

public enum AllowStatus: String, Codable, Hashable {
    
    case allowed = "ALLOWED"
    case pending = "PENDING"
    case rejected = "REJECTED"
    
    public var text: String {
        switch self {
        case .allowed: "승인됨"
        case .pending: "대기중"
        case .rejected: "거절됨"
        }
    }
}
