//
//  PostNightStudyRequest.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

struct PostNightStudyRequest: RequestProtocol {
    
    let place: String
    let content: String
    let doNeedPhone: Bool
    let reasonForPhone: String?
    let startAt: String
    let endAt: String
}
