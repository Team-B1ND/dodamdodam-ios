//
//  Local.swift
//  ProjectDescriptionHelpers
//
//  Created by hhhello0507 on 9/17/24.
//

import Foundation
import RealmSwift
import Domain

public final class MealEntity: Object, Expired {
    
    @Persisted(primaryKey: true) var id: UUID = .init()
    @Persisted public var exists: Bool
    @Persisted public var date: Date // unique (date.month, date.day)
    @Persisted public var breakfast: MealDetailEntity?
    @Persisted public var lunch: MealDetailEntity?
    @Persisted public var dinner: MealDetailEntity?
    @Persisted public var expiredAt: Date
    public static var dayLater: Int = 14 // 유효기간 14일
    
    public static func from(_ meal: MealModel) -> MealEntity {
        let entity = MealEntity()
        entity.exists = meal.exists
        entity.date = meal.date
        if let breakfast = meal.breakfast {
            entity.breakfast = MealDetailEntity.from(breakfast)
        }
        if let lunch = meal.lunch {
            entity.lunch = MealDetailEntity.from(lunch)
        }
        if let dinner = meal.dinner {
            entity.dinner = MealDetailEntity.from(dinner)
        }
        entity.expiredAt = Self.expiredDate
        return entity
    }
}
