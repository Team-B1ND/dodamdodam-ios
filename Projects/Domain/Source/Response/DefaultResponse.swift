//
//  DefaultResponse.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

public struct DefaultResponse: ResponseProtocol {
    public let status: Int
    public let message: String
    
    public init(status: Int, message: String) {
        self.status = status
        self.message = message
    }
}
