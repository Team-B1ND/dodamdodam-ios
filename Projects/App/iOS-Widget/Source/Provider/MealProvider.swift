//
//  DodamMealProvider.swift
//  DodamDodam
//
//  Created by hhhello0507 on 7/23/24.
//

import WidgetKit
import Domain

struct MealProvider: TimelineProvider {
    func placeholder(in context: Context) -> MealEntry {
        .empty
    }
    
    func getSnapshot(in context: Context, completion: @escaping (MealEntry) -> Void) {
        let meal = Meal(
            details: [
                .init(name: "퀴노아녹두죽", allergies: []),
                .init(name: "채소샐러드", allergies: []),
                .init(name: "우자드레싱", allergies: []),
                .init(name: "깍두기", allergies: []),
                .init(name: "초코첵스시리얼+우ㅁㅁㅁㅁㅁ유", allergies: []),
                .init(name: "초코크로와상", allergies: [])
            ],
            calorie: 941
        )
        let entry = MealEntry(
            date: .now,
            meal: MealResponse(
                exists: true,
                date: .now,
                breakfast: meal,
                lunch: nil,
                dinner: nil
            )
        )
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        
    }
}
