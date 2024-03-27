//
//  FetchMonthlyMealRequest.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

import Foundation

struct FetchMonthlyMealRequest: RequestProtocol {
    
    let year: Int
    let month: Int
}
