//
//  MealModel.swift
//  Domain
//
//  Created by hhhello0507 on 9/17/24.
//

import Foundation

public struct MealModel: ModelProtocol {
    
    public let exists: Bool
    public let date: Date
    public let breakfast: Meal?
    public let lunch: Meal?
    public let dinner: Meal?
    
    public var meals: [Meal] {
        [self.breakfast, self.lunch, self.dinner].compactMap { $0 }
    }
    
    public init(exists: Bool, date: Date, breakfast: Meal?, lunch: Meal?, dinner: Meal?) {
        self.exists = exists
        self.date = date
        self.breakfast = breakfast
        self.lunch = lunch
        self.dinner = dinner
    }
    
    public func getMeal(type: MealType) -> Meal? {
        switch type {
        case .breakfast:
            breakfast
        case .lunch:
            lunch
        case .dinner:
            dinner
        }
    }
}
