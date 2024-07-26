//
//  PostJoinRequest.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

import SwiftBok

@Init()
@Members()
public struct PostJoinRequest: RequestProtocol {
    
    public let id: String?
    public let email: String?
    public let name: String?
    public let phone: String?
    public let pw: String?
    public let grade: Int?
    public let room: Int?
    public let number: Int?
}
