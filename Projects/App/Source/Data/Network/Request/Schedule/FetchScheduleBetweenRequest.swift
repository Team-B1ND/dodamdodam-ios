//
//  FetchScheduleBetweenRequest.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

import Foundation

struct FetchScheduleBetweenRequest: RequestProtocol {
    
    let startDate: String
    let endDate: String
}
