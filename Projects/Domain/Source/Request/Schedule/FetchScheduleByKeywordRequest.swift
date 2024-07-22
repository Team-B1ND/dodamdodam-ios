//
//  FetchScheduleByKeywordRequest.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

import SwiftBok

@Init()
@Members()
public struct FetchScheduleByKeywordRequest: RequestProtocol {
    
    public let keyword: String
}
