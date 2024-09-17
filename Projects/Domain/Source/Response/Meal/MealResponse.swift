//
//  MealResponse.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

import Foundation
public struct MealResponse: ResponseProtocol {
    
    public let exists: Bool
    public let date: Date
    public let breakfast: MealDetail?
    public let lunch: MealDetail?
    public let dinner: MealDetail?
    
    public init(exists: Bool, date: Date, breakfast: MealDetail?, lunch: MealDetail?, dinner: MealDetail?) {
        self.exists = exists
        self.date = date
        self.breakfast = breakfast
        self.lunch = lunch
        self.dinner = dinner
    }
    
    public func toModel() -> MealModel {
        MealModel(
            exists: exists,
            date: date,
            breakfast: breakfast,
            lunch: lunch,
            dinner: dinner
        )
    }
}
