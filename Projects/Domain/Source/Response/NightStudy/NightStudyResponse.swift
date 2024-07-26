//
//  NightStudyResponse.swift
//  DodamDodam
//
//  Created by Mercen on 3/28/24.
//

import Foundation
import SwiftBok

@Init()
@Members()
public struct NightStudyResponse: ResponseProtocol {
    
    public let id: Int
    public let content: String
    public let status: AllowStatus
    public let doNeedPhone: Bool
    public let reasonForPhone: String?
    public let student: Student
    public let rejectReason: String?
    public let place: Place
    public let startAt: Date
    public let endAt: Date
    public let createdAt: Date
    public let modifiedAt: Date?
}
