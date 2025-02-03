//
//  ScheduleResponse.swift
//  DodamDodam
//
//  Created by Mercen on 3/28/24.
//

public struct ScheduleResponse: ResponseProtocol {
    
    public let id: Int
    public let name: String
    public let place: SchedulePlace
    public let type: ScheduleType
    public let date: [String]
    public let targetGrades: [Grade]
    
    public init(id: Int, name: String, place: SchedulePlace, type: ScheduleType, date: [String], targetGrades: [Grade]) {
        self.id = id
        self.name = name
        self.place = place
        self.type = type
        self.date = date
        self.targetGrades = targetGrades
    }
}
