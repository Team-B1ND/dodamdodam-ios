//
//  PostNightStudyRequest.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

import SwiftBok

@Init()
@Members()
public struct PostNightStudyRequest: RequestProtocol {
    
    public let place: String
    public let content: String
    public let doNeedPhone: Bool
    public let reasonForPhone: String?
    public let startAt: String
    public let endAt: String
}
