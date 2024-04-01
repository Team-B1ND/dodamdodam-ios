//
//  FetchMealRequest.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

struct FetchMealRequest: RequestProtocol {
    
    let year: Int
    let month: Int
    let day: Int
}
