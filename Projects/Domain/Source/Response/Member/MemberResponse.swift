//
//  MemberResponse.swift
//  DodamDodam
//
//  Created by Mercen on 3/28/24.
//
import Foundation
import SwiftBok

@Init()
@Members()
public struct MemberResponse: ResponseProtocol {
    
    public let id: String
    public let name: String
    public let email: String
    public let role: Role
    public let status: ActiveStatus
    public let profileImage: String?
    public let phone: String
    public let student: Student?
    public let teacher: Teacher?
    public let createdAt: Date
    public let modifiedAt: Date?
}
