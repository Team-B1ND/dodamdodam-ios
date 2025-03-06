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
    
    public var korean: String {
        switch self {
        case .student: "학생"
        case .teacher: "선생님"
        case .admin: "어드민"
        case .parent: "학부모"
        }
    }
}
