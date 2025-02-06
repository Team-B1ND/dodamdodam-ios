//
//  DivisionResponse.swift
//  Domain
//
//  Created by hhhello0507 on 2/4/25.
//

import Foundation

public struct DivisionDetailResponse: ResponseProtocol {
    public let id: Int
    public let divisionName: String
    public let description: String
    public let myPermission: DivisionPermission
    
    public init(id: Int, divisionName: String, description: String, myPermission: DivisionPermission) {
        self.id = id
        self.divisionName = divisionName
        self.description = description
        self.myPermission = myPermission
    }
}
