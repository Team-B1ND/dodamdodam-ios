//
//  PostOutSleepingRequest.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

public struct PostOutSleepingRequest: RequestProtocol {
    
    public let reason: String
    public let startAt: String
    public let endAt: String
    
    public init(reason: String, startAt: String, endAt: String) {
        self.reason = reason
        self.startAt = startAt
        self.endAt = endAt
    }
}
