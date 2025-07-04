//
//  NightStudyBanRequest.swift
//  Domain
//
//  Created by 김은찬 on 7/4/25.
//

import Foundation

public struct NightStudyBanRequest: RequestProtocol {
    public let student: Int
    public let reason: String
    public let ended: String
    
    public init(student: Int, reason: String, ended: String) {
        self.student = student
        self.reason = reason
        self.ended = ended
    }
}
