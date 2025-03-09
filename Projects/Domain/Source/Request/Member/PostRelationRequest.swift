//
//  PostRelationRequest.swift
//  Domain
//
//  Created by hhhello0507 on 2/25/25.
//

import Foundation

public struct PostRelationRequest: RequestProtocol {
    public let code: String
    public let relation: String
    
    public init(code: String, relation: String) {
        self.code = code
        self.relation = relation
    }
}
