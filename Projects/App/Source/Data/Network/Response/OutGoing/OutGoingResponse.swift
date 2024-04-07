//
//  OutGoingResponse.swift
//  DodamDodam
//
//  Created by Mercen on 3/28/24.
//

struct OutGoingResponse: ResponseProtocol {
    
    let id: Int
    let reason: String
    let status: AllowStatus
    let student: Student
    let rejectReason: String?
    let startAt: String
    let endAt: String
    let createdAt: String
    let modifiedAt: String?
}
