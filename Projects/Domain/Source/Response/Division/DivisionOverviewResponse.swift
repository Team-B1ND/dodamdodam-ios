//
//  DivisionResponse.swift
//  Domain
//
//  Created by hhhello0507 on 2/4/25.
//

import Foundation

public struct DivisionOverviewResponse: ResponseProtocol {
    public let id: Int
    public let name: String
    
    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
