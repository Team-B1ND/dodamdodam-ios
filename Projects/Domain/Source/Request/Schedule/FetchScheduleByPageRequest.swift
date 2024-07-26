//
//  FetchScheduleByPageRequest.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

import SwiftBok

@Init()
@Members()
public struct FetchScheduleByPageRequest: RequestProtocol {
    
    public let limit: Int
    public let page: Int
}
