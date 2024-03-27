//
//  FetchScheduleByPageRequest.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

import Foundation

struct FetchScheduleByPageRequest: RequestProtocol {
    
    let limit: Int
    let page: Int
}
