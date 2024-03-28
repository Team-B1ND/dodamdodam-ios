//
//  PointResponse.swift
//  DodamDodam
//
//  Created by Mercen on 3/28/24.
//

import Foundation

struct PointResponse: ResponseProtocol {
    
    let id: Int
    let student: Student
    let teacher: Teacher
    let reason: PointReason
    let issueAt: String
}
