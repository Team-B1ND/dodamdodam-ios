//
//  PatchMemberInfoRequest.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

struct PatchMemberInfoRequest: RequestProtocol {
    
    let email: String?
    let name: String?
    let profileImage: String?
}
