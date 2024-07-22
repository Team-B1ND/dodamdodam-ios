//
//  MealMenu.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

import Foundation
import SwiftBok

@Init()
@Members()
public struct MealMenu: Codable, Hashable {
    
    public let name: String
    public let allergies: [Int]
}
