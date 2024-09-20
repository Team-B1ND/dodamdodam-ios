//
//  MealDetailEntity.swift
//  Local
//
//  Created by hhhello0507 on 9/17/24.
//

import Foundation
import RealmSwift
import Domain

public final class MealDetailEntity: Object {
    @Persisted public var details: List<MealMenuEntity>
    @Persisted public var calorie: Double
    
    public static func from(_ mealDetail: MealDetail) -> MealDetailEntity {
        let entity = MealDetailEntity()
        let mealMenusEntity = mealDetail.details.map { MealMenuEntity.from($0) }
        entity.details.append(objectsIn: mealMenusEntity)
        entity.calorie = mealDetail.calorie
        return entity
    }
}
