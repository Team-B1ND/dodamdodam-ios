//
//  PostLoginRequest.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

public struct PostLoginRequest: RequestProtocol {
    
    public let id: String
    public let pw: String
    public let pushToken: String
    
    public init(id: String, pw: String, pushToken: String) {
        self.id = id
        self.pw = pw
        self.pushToken = pushToken
    }
}
