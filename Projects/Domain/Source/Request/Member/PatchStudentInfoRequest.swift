//
//  PatchStudentInfoRequest.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

import SwiftBok

@Init()
@Members()
public struct PatchStudentInfoRequest: RequestProtocol {
    
    public let grade: Int?
    public let room: Int?
    public let number: Int?
}
