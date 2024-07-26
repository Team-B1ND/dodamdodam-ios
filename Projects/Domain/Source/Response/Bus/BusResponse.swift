//
//  BusResponse.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

import SwiftBok

@Init()
@Members()
public struct BusResponse: ResponseProtocol {
    
    public let id: Int
    public let busName: String
    public let description: String
    public let peopleLimit: Int
    public let applyCount: Int
    public let leaveTime: String
    public let timeRequired: String
}
