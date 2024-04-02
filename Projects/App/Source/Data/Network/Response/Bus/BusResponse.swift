//
//  BusResponse.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

struct BusResponse: ResponseProtocol {
    
    let id: Int
    let busName: String
    let description: String
    let peopleLimit: Int
    let applyCount: Int
    let leaveTime: String
    let timeRequired: String
}
