//
//  PostJoinRequest.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

public struct PostJoinRequest: RequestProtocol {
    
    public let id: String?
    public let email: String?
    public let name: String?
    public let phone: String?
    public let pw: String?
    public let grade: Int?
    public let room: Int?
    public let number: Int?
    public init(id: String?, email: String?, name: String?, phone: String?, pw: String?, grade: Int?, room: Int?, number: Int?) {
        self.id = id
        self.email = email
        self.name = name
        self.phone = phone
        self.pw = pw
        self.grade = grade
        self.room = room
        self.number = number
    }
}
