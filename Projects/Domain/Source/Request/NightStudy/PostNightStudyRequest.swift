//
//  PostNightStudyRequest.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

public struct PostNightStudyRequest: RequestProtocol {
    
    public let place: String
    public let content: String
    public let doNeedPhone: Bool
    public let reasonForPhone: String?
    public let startAt: String
    public let endAt: String
    
    public init(place: String, content: String, doNeedPhone: Bool, reasonForPhone: String?, startAt: String, endAt: String) {
        self.place = place
        self.content = content
        self.doNeedPhone = doNeedPhone
        self.reasonForPhone = reasonForPhone
        self.startAt = startAt
        self.endAt = endAt
    }
}
