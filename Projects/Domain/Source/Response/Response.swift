//
//  Response.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

public struct Response<T: ResponseProtocol>: ResponseProtocol {
    
    public let status: Int
    public let message: String
    public let data: T
    
    public init(status: Int, message: String, data: T) {
        self.status = status
        self.message = message
        self.data = data
    }
}
