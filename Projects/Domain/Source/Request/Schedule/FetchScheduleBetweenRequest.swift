//
//  FetchScheduleBetweenRequest.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

public struct FetchScheduleBetweenRequest: RequestProtocol {
    
    public let startDate: String
    public let endDate: String
    
    public init(startDate: String, endDate: String) {
        self.startDate = startDate
        self.endDate = endDate
    }
}
