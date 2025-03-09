//
//  Student.swift
//  DodamDodam
//
//  Created by Mercen on 3/28/24.
//

import Foundation

public struct Student: Codable, Hashable {
    
    public let id: Int
    public let name: String
    public let grade: Int
    public let room: Int
    public let number: Int
    public let code: String
    public init(id: Int, name: String, grade: Int, room: Int, number: Int, code: String) {
        self.id = id
        self.name = name
        self.grade = grade
        self.room = room
        self.number = number
        self.code = code
    }
}
