//
//  PatchMemberInfoRequest.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

import SwiftBok

@Init()
@Members()
public struct PatchMemberInfoRequest: RequestProtocol {
    
    public let email: String?
    public let name: String?
    public let profileImage: String?
}
