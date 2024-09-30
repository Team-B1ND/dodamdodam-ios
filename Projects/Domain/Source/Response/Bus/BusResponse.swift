//
//  BusResponse.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

public struct BusResponse: ResponseProtocol {
    
    public let id: Int
    public let busName: String
    public let description: String
    public let peopleLimit: Int
    public let applyCount: Int
    public let leaveTime: String
    public let timeRequired: String
    
    public init(id: Int, busName: String, description: String, peopleLimit: Int, applyCount: Int, leaveTime: String, timeRequired: String) {
        self.id = id
        self.busName = busName
        self.description = description
        self.peopleLimit = peopleLimit
        self.applyCount = applyCount
        self.leaveTime = leaveTime
        self.timeRequired = timeRequired
    }
}
