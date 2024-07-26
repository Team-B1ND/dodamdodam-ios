//
//  Response.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import SwiftBok

@Init()
@Members()
public struct Response<T: ResponseProtocol>: ResponseProtocol {
    
    public let status: Int
    public let message: String
    public let data: T
}
