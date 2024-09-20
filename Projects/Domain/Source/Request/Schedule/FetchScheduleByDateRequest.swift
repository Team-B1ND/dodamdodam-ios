//
//  FetchScheduleByDateRequest.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//
public struct FetchScheduleByDateRequest: RequestProtocol {
    
    public let year: Int
    public let month: Int
    public let day: Int
    
    public init(year: Int, month: Int, day: Int) {
        self.year = year
        self.month = month
        self.day = day
    }
}
