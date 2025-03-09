//
//  ConnectStudentResponse.swift
//  Domain
//
//  Created by hhhello0507 on 2/25/25.
//

import Foundation

public struct ConnectStudentResponse: ResponseProtocol {
    public let profileImage: String?
    public let name: String
    public let relation: String
    
    public init(profileImage: String?, name: String, relation: String) {
        self.profileImage = profileImage
        self.name = name
        self.relation = relation
    }
    
    public func toModel() -> ConnectStudent {
        .init(profileImage: profileImage, name: name, code: "", relation: relation)
    }
}
