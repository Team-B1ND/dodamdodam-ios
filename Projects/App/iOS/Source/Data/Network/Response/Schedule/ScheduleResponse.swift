//
//  ScheduleResponse.swift
//  DodamDodam
//
//  Created by Mercen on 3/28/24.
//

struct ScheduleResponse: ResponseProtocol {
    
    let id: Int
    let name: String
    let place: Place
    let type: ScheduleType
    let date: [String]
    let targetGrades: [Grade]
}
