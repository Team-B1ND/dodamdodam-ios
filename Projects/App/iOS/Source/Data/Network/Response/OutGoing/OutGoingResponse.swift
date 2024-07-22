//
//  OutGoingResponse.swift
//  DodamDodam
//
//  Created by Mercen on 3/28/24.
//

import Foundation

struct OutGoingResponse: ResponseProtocol {
    
    let id: Int
    let reason: String
    let status: AllowStatus
    let student: Student
    let rejectReason: String?
    let startAt: Date
    let endAt: Date
    let createdAt: Date
    let modifiedAt: Date?
}
