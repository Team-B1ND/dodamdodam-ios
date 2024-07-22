//
//  MealEntry.swift
//  DodamDodam
//
//  Created by hhhello0507 on 7/23/24.
//

import WidgetKit
import Domain

struct MealEntry: TimelineEntry {
    let date: Date
    let meal: Meal
}

extension MealEntry {
    static var empty: MealEntry {
        MealEntry(
            date: .now,
            meal: .init(
                details: [],
                calorie: 0
            )
        )
    }
}
