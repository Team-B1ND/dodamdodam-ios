//
//  ClubTeacher.swift
//  Domain
//
//  Created by dgsw30 on 3/9/25.
//

import Foundation

public struct ClubTeacher: Codable, Hashable {
    public let name: String
    public let position: String
    public let tel: String
    
    public init(name: String, position: String, tel: String) {
        self.name = name
        self.position = position
        self.tel = tel
    }
}
