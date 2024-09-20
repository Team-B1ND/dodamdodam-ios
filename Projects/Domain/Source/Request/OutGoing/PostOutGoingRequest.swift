//
//  PostOutGoingRequest.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

import SwiftBok

@Init()
@Members()
public struct PostOutGoingRequest: RequestProtocol {
    
    public let reason: String
    public let startAt: String
    public let endAt: String
    public let dinnerOrNot: Bool
}
