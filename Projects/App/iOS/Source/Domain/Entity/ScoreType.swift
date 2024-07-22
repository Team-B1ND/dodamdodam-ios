//
//  ScoreType.swift
//  DodamDodam
//
//  Created by Mercen on 3/28/24.
//

import Foundation

enum ScoreType: String, Codable, Hashable {
    
    case bonus = "BONUS"
    case minus = "MINUS"
    case offset = "OFFSET"
}
