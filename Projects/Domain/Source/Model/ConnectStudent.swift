//
//  ConnectStudent.swift
//  Domain
//
//  Created by hhhello0507 on 2/4/25.
//

import Foundation

public struct ConnectStudent: ModelProtocol {
    public let profileImage: String?
    public let name: String
    public let code: String
    public let relation: String
    
    public init(profileImage: String?, name: String, code: String, relation: String) {
        self.profileImage = profileImage
        self.name = name
        self.code = code
        self.relation = relation
    }
}
