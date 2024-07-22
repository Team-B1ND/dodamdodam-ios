//
//  MemberResponse.swift
//  DodamDodam
//
//  Created by Mercen on 3/28/24.
//
import Foundation

struct MemberResponse: ResponseProtocol {
    
    let id: String
    let name: String
    let email: String
    let role: Role
    let status: ActiveStatus
    let profileImage: String?
    let phone: String
    let student: Student?
    let teacher: Teacher?
    let createdAt: Date
    let modifiedAt: Date?
}
