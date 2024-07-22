//
//  Response.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

struct Response<T: ResponseProtocol>: ResponseProtocol {
    
    var status: Int
    var message: String
    var data: T
}
