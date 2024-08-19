//
//  Member.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Foundation
import SwiftBok

@Init()
@Members()
public struct Member: Codable, Hashable {
    
    public let createdAt: Date
    public let modifiedAt: Date?
    public let id: String
    public let name: String
    public let role: Role
    public let status: ActiveStatus
    public let profileImage: URL?
    public let phone: String
}
