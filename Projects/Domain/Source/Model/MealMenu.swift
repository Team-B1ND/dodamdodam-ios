//
//  MealMenu.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

import Foundation

public struct MealMenu: Codable, Hashable {
    
    public let name: String
    public let allergies: [Int]
    
    public init(name: String, allergies: [Int]) {
        self.name = name
        self.allergies = allergies
    }
}
