//
//  MealEntityExt.swift
//  Local
//
//  Created by hhhello0507 on 9/17/24.
//

import Foundation
import Domain
import Local

public extension MealEntity {
    func toModel() -> MealModel {
        MealModel(
            exists: exists,
            date: date,
            breakfast: breakfast?.toModel(),
            lunch: lunch?.toModel(),
            dinner: dinner?.toModel()
        )
    }
}

extension MealDetailEntity {
    func toModel() -> MealDetail {
        MealDetail(
            details: details.map { $0.toModel() },
            calorie: calorie
        )
    }
}

extension MealMenuEntity {
    func toModel() -> MealMenu {
        MealMenu(name: name, allergies: Array(allergies))
    }
}
