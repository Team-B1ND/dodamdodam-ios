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
    let meal: MealResponse
}

extension MealEntry {
    static var empty: MealEntry {
        MealEntry(
            date: .now,
            meal: MealResponse(
                exists: true, 
                date: .now,
                breakfast: nil,
                lunch: nil,
                dinner: nil
            )
        )
    }
}
