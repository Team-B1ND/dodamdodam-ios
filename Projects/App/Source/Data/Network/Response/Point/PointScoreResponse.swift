//
//  PointScoreResponse.swift
//  DodamDodam
//
//  Created by Mercen on 3/28/24.
//

import Foundation

struct PointScoreResponse: ResponseProtocol {
    
    let id: Int
    let bonus: Int
    let minus: Int
    let offset: Int
    let type: PointType
    let student: Student
}
