//
//  PointScoreResponse.swift
//  DodamDodam
//
//  Created by Mercen on 3/28/24.
//
import SwiftBok

@Init()
@Members()
public struct PointScoreResponse: ResponseProtocol {
    
    public let id: Int
    public let bonus: Int
    public let minus: Int
    public let offset: Int
    public let type: PointType
    public let student: Student
}
