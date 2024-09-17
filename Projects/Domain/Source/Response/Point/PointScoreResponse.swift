//
//  PointScoreResponse.swift
//  DodamDodam
//
//  Created by Mercen on 3/28/24.
//

public struct PointScoreResponse: ResponseProtocol {
    
    public let id: Int
    public let bonus: Int
    public let minus: Int
    public let offset: Int
    public let type: PointType
    public let student: Student
    
    public init(id: Int, bonus: Int, minus: Int, offset: Int, type: PointType, student: Student) {
        self.id = id
        self.bonus = bonus
        self.minus = minus
        self.offset = offset
        self.type = type
        self.student = student
    }
}
