//
//  FetchScheduleBetweenRequest.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

public struct FetchScheduleBetweenRequest: RequestProtocol {
    
    public let startAt: String
    public let endAt: String
    
    public init(startAt: String, endAt: String) {
        self.startAt = startAt
        self.endAt = endAt
    }
}
