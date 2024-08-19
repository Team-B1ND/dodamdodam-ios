//
//  Meal.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

import Foundation
import SwiftBok

@Init()
@Members()
public struct Meal: Codable, Hashable {
    
    public let details: [MealMenu]
    public let calorie: Double
}
