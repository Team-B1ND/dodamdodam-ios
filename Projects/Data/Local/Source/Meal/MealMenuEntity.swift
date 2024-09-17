//
//  MealMenuEntity.swift
//  Local
//
//  Created by hhhello0507 on 9/17/24.
//

import Foundation
import RealmSwift
import Domain

public final class MealMenuEntity: Object {
    @Persisted public var name: String
    @Persisted public var allergies: List<Int>
    
    static func from(_ mealMenu: MealMenu) -> MealMenuEntity {
        let entity = MealMenuEntity()
        entity.name = mealMenu.name
        entity.allergies.append(objectsIn: mealMenu.allergies)
        return entity
    }
}
