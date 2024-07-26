//
//  DefaultResponse.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

import SwiftBok

@Init()
@Members()
public struct DefaultResponse: ResponseProtocol {
    public let status: Int
    public let message: String
}
