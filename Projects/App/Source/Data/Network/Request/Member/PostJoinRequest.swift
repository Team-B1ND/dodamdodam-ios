//
//  PostJoinRequest.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

struct PostJoinRequest: RequestProtocol {
    
    let id: String?
    let email: String?
    let name: String?
    let phone: String?
    let pw: String?
    let grade: Int?
    let room: Int?
    let number: Int?
}
