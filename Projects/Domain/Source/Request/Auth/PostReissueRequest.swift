//
//  PostReissueRequest.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

public struct PostReissueRequest: RequestProtocol {
    
    public let refreshToken: String
    
    public init(refreshToken: String) {
        self.refreshToken = refreshToken
    }
}
