//
//  BusResponse.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

import Foundation

public struct BusResponse: ResponseProtocol, Identifiable {
    
    public let id: Int
    public let busName: String
    public let description: String
    public let peopleLimit: Int
    public let status: BusStatus
    public let applyCount: Int
    public let leaveTime: Date
    public let timeRequired: Date
    
    public init(id: Int, busName: String, description: String, peopleLimit: Int, status: BusStatus, applyCount: Int, leaveTime: Date, timeRequired: Date) {
        self.id = id
        self.busName = busName
        self.description = description
        self.peopleLimit = peopleLimit
        self.status = status
        self.applyCount = applyCount
        self.leaveTime = leaveTime
        self.timeRequired = timeRequired
    }
}
