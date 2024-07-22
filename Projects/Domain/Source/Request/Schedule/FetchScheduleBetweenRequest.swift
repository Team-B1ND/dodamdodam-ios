//
//  FetchScheduleBetweenRequest.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

import SwiftBok

@Init()
@Members()
public struct FetchScheduleBetweenRequest: RequestProtocol {
    
    public let startDate: String
    public let endDate: String
}
