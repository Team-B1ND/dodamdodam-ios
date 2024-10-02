//
//  PatchPasswordRequest.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

public struct PatchPasswordRequest: RequestProtocol {
    
    public let password: String
    
    public init(password: String) {
        self.password = password
    }
}
