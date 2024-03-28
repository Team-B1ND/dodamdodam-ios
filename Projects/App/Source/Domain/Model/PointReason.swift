//
//  PointReason.swift
//  DodamDodam
//
//  Created by Mercen on 3/28/24.
//

import Foundation

struct PointReason: Codable, Hashable {
    
    let id: Int
    let reason: String
    let score: Int
    let scoreType: ScoreType
    let pointType: PointType
}
