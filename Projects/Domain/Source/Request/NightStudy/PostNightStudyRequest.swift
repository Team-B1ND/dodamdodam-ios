//
//  PostNightStudyRequest.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

public struct PostNightStudyRequest: RequestProtocol {
    
    public let content: String
    public let type: String
    public let doNeedPhone: Bool
    public let reasonForPhone: String?
    public let startAt: String
    public let endAt: String
    
    public init(content: String, type: String, doNeedPhone: Bool, reasonForPhone: String?, startAt: String, endAt: String) {
        self.content = content
        self.type = type
        self.doNeedPhone = doNeedPhone
        self.reasonForPhone = reasonForPhone
        self.startAt = startAt
        self.endAt = endAt
    }
}
