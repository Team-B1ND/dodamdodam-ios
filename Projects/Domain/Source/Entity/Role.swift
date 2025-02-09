//
//  Role.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Foundation

public enum Role: String, Codable, Hashable {
    
    case student = "STUDENT"
    case teacher = "TEACHER"
    case admin = "ADMIN"
    case parent = "PARENT"
}
