//
//  FetchPointRequest.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

public struct FetchPointRequest: RequestProtocol {
    
    public let type: PointType
    
    public init(type: PointType) {
        self.type = type
    }
}
