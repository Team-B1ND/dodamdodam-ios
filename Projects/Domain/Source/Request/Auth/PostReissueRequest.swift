//
//  PostReissueRequest.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import SwiftBok

@Init()
@Members()
public struct PostReissueRequest: RequestProtocol {
    
    public let refreshToken: String
}
