//
//  Response.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Foundation

struct Response<T: ResponseProtocol>: ResponseProtocol {
    var status: Int
    var message: String
    var data: T
}
