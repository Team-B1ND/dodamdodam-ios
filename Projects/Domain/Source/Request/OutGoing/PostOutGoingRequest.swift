//
//  PostOutGoingRequest.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

public struct PostOutGoingRequest: RequestProtocol {
    
    public let reason: String
    public let startAt: String
    public let endAt: String
    public let dinnerOrNot: Bool
    
    public init(reason: String, startAt: String, endAt: String, dinnerOrNot: Bool) {
        self.reason = reason
        self.startAt = startAt
        self.endAt = endAt
        self.dinnerOrNot = dinnerOrNot
    }
}
