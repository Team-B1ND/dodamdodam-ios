//
//  ConnectStudentRequest.swift
//  Domain
//
//  Created by hhhello0507 on 2/4/25.
//


public struct ConnectStudentRequest: Codable, ModelProtocol {
    public let code: String
    public let relation: String
    
    public init(code: String, relation: String) {
        self.code = code
        self.relation = relation
    }
}
