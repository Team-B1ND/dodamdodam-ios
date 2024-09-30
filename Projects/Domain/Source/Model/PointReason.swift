//
//  PointReason.swift
//  DodamDodam
//
//  Created by Mercen on 3/28/24.
//

import Foundation

public struct PointReason: Codable, Hashable {
    
    public let id: Int
    public let reason: String
    public let score: Int
    public let scoreType: ScoreType
    public let pointType: PointType
    
    public init(id: Int, reason: String, score: Int, scoreType: ScoreType, pointType: PointType) {
        self.id = id
        self.reason = reason
        self.score = score
        self.scoreType = scoreType
        self.pointType = pointType
    }
}
