//
//  Meal.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

import Foundation

public struct Meal: Codable, Hashable {
    
    public let details: [MealMenu]
    public let calorie: Double
    
    public init(details: [MealMenu], calorie: Double) {
        self.details = details
        self.calorie = calorie
    }
}
