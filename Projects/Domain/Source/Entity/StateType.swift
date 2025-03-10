//
//  StateType.swift
//  Domain
//
//  Created by dgsw30 on 2/25/25.
//

import Foundation

public enum StateType: String, Codable, Hashable {
    case allowed = "ALLOWED"
    case pending = "PENDING"
    case rejected = "REJECTED"
    case waiting = "WAITING"
    case deleted = "DELETED"
}
