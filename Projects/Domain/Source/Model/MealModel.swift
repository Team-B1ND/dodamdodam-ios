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
    public let breakfast: MealDetail?
    public let lunch: MealDetail?
    public let dinner: MealDetail?
    
    public var meals: [MealDetail] {
        [self.breakfast, self.lunch, self.dinner].compactMap { $0 }
    }
    
    public init(exists: Bool, date: Date, breakfast: MealDetail?, lunch: MealDetail?, dinner: MealDetail?) {
        self.exists = exists
        self.date = date
        self.breakfast = breakfast
        self.lunch = lunch
        self.dinner = dinner
    }
    
    public func getMeal(type: MealType) -> MealDetail? {
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
