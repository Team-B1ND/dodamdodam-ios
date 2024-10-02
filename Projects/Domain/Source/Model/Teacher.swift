//
//  Teacher.swift
//  DodamDodam
//
//  Created by Mercen on 3/28/24.
//

import Foundation

public struct Teacher: Codable, Hashable {
    
    public let id: Int?
    public let tel: String
    public let position: String
    
    public init(id: Int?, tel: String, position: String) {
        self.id = id
        self.tel = tel
        self.position = position
    }
}
