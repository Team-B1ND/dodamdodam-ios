//
//  NoticeStatus.swift
//  Domain
//
//  Created by dgsw8th61 on 2/8/25.
//

import Foundation

public enum NoticeStatus: String, Codable, Hashable {
    
    case created = "CREATED"
    case draft = "DRAFT"
    case deleted = "DELETED"
    
}
