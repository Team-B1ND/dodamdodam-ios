//
//  NightStudyResponse.swift
//  DodamDodam
//
//  Created by Mercen on 3/28/24.
//

struct NightStudyResponse: ResponseProtocol {
    
    let id: Int
    let content: String
    let status: AllowStatus
    let doNeedPhone: Bool
    let reasonForPhone: String?
    let student: Student
    let rejectReason: String?
    let place: Place
    let startAt: String
    let endAt: String
    let createdAt: String
    let modifiedAt: String?
}
