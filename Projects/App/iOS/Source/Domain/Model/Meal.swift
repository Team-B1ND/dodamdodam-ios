//
//  Meal.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

import Foundation

struct Meal: Codable, Hashable {
    
    let details: [MealMenu]
    let calorie: Double
}
