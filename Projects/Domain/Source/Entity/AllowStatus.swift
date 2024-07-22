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
}
