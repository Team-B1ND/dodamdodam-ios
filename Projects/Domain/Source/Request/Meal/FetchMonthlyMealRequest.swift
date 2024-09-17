//
//  FetchMonthlyMealRequest.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

public struct FetchMonthlyMealRequest: RequestProtocol {
    
    public let year: Int
    public let month: Int
    
    public init(year: Int, month: Int) {
        self.year = year
        self.month = month
    }
}
