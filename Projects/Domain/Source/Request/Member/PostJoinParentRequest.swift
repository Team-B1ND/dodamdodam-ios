//
//  PostJoinParentRequest.swift
//  Domain
//
//  Created by hhhello0507 on 2/4/25.
//

import Foundation

public struct PostJoinParentRequest: RequestProtocol {
    public let id: String
    public let pw: String
    public let name: String
    public let relationInfo: [ConnectStudentRequest]
    public let phone: String
    
    public init(id: String, pw: String, name: String, relationInfo: [ConnectStudentRequest], phone: String) {
        self.id = id
        self.pw = pw
        self.name = name
        self.relationInfo = relationInfo
        self.phone = phone
    }
}
