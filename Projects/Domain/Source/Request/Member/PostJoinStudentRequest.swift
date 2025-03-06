//
//  PostJoinRequest.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

public struct PostJoinStudentRequest: RequestProtocol {
    
    public let id: String
    public let pw: String
    public let name: String
    public let email: String
    public let phone: String
    public let grade: Int
    public let room: Int
    public let number: Int
    
    public init(id: String, pw: String, name: String, email: String, phone: String, grade: Int, room: Int, number: Int) {
        self.id = id
        self.pw = pw
        self.name = name
        self.email = email
        self.phone = phone
        self.grade = grade
        self.room = room
        self.number = number
    }
}
