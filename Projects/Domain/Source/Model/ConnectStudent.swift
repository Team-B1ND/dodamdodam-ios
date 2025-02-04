//
//  ConnectStudentRequest.swift
//  Domain
//
//  Created by hhhello0507 on 2/4/25.
//

import Foundation

public struct ConnectStudent: ModelProtocol {
    public let code: String
    public let relation: String
    public let profileImage: URL?
    
    public init(code: String, relation: String, profileImage: URL?) {
        self.code = code
        self.relation = relation
        self.profileImage = profileImage
    }
    
    public func toRequest() -> ConnectStudentRequest {
        .init(code: code, relation: relation)
    }
}
