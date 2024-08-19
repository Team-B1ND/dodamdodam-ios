//
//  PointReason.swift
//  DodamDodam
//
//  Created by Mercen on 3/28/24.
//

import Foundation
import SwiftBok

@Init()
@Members()
public struct PointReason: Codable, Hashable {
    
    public let id: Int
    public let reason: String
    public let score: Int
    public let scoreType: ScoreType
    public let pointType: PointType
}
