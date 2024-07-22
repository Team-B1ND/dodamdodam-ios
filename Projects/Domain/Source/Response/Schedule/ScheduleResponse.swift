//
//  ScheduleResponse.swift
//  DodamDodam
//
//  Created by Mercen on 3/28/24.
//
import SwiftBok

@Init()
@Members()
public struct ScheduleResponse: ResponseProtocol {
    
    public let id: Int
    public let name: String
    public let place: Place
    public let type: ScheduleType
    public let date: [String]
    public let targetGrades: [Grade]
}
