//
//  DivisionPermission.swift
//  Domain
//
//  Created by hhhello0507 on 2/4/25.
//

import Foundation

public enum DivisionPermission: String, Codable, Hashable {
    
    case reader = "READER"
    case writer = "WRITER"
    case admin = "ADMIN"
}
