//
//  OutGoingResponse.swift
//  DodamDodam
//
//  Created by Mercen on 3/28/24.
//

import Foundation
import SwiftBok

@Init()
@Members()
public struct OutGoingResponse: ResponseProtocol {
    
    public let id: Int
    public let reason: String
    public let status: AllowStatus
    public let student: Student
    public let rejectReason: String?
    public let startAt: Date
    public let endAt: Date
    public let createdAt: Date
    public let modifiedAt: Date?
}
