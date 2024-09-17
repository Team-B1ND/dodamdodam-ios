//
//  PatchStudentInfoRequest.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

public struct PatchStudentInfoRequest: RequestProtocol {
    
    public let grade: Int?
    public let room: Int?
    public let number: Int?
    
    public init(grade: Int?, room: Int?, number: Int?) {
        self.grade = grade
        self.room = room
        self.number = number
    }
}
