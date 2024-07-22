//
//  PostLoginRequest.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import SwiftBok

@Init()
@Members()
public struct PostLoginRequest: RequestProtocol {
    
    public let id: String
    public let pw: String
}
