//
//  PatchStudentInfoRequest.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

struct PatchStudentInfoRequest: RequestProtocol {
    
    let grade: Int?
    let room: Int?
    let number: Int?
}
