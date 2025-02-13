//
//  ConnectStudent.swift
//  Domain
//
//  Created by hhhello0507 on 2/4/25.
//

import Foundation

public struct ConnectStudent: ModelProtocol {
    public let member: MemberResponse
    public let code: String
    public let relation: String
    
    public init(member: MemberResponse, code: String, relation: String) {
        self.member = member
        self.code = code
        self.relation = relation
    }
    
    public func toRequest() -> ConnectStudentRequest {
        .init(code: code, relation: relation)
    }
}
