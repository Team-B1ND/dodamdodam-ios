//
//  ReissueResponse.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

public struct ReissueResponse: ResponseProtocol {
    public let accessToken: String
    
    public init(accessToken: String) {
        self.accessToken = accessToken
    }
}
