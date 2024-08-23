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
    let meal: MealResponse?
}

extension MealEntry {
    static let empty = MealEntry(
        date: .now,
        meal: .empty
    )
    
    static func of(_ date: Date) -> MealEntry {
        MealEntry(
            date: date,
            meal: nil
        )
    }
}

extension MealResponse {
    static let empty = MealResponse(
        exists: true,
        date: .now,
        breakfast: nil,
        lunch: nil,
        dinner: nil
    )
}
