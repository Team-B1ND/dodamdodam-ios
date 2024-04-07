//
//  Member.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Foundation

struct Member: Codable, Hashable {
    
    let createdAt: String
    let modifiedAt: String?
    let id: String
    let name: String
    let role: Role
    let status: ActiveStatus
    let profileImage: URL?
    let phone: String
}
