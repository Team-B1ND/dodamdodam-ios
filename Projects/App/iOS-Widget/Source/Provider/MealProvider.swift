//
//  DodamMealProvider.swift
//  DodamDodam
//
//  Created by hhhello0507 on 7/23/24.
//

import WidgetKit
import Domain
import Shared
import DIContainer

struct MealProvider: TimelineProvider {
    
    @Inject var mealRepository: any MealRepository
    func placeholder(in context: Context) -> MealEntry {
        
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
            meal: MealModel(
                exists: true,
                date: .now,
                breakfast: meal,
                lunch: meal,
                dinner: meal
            )
        )
        return entry
    }
    
    func getSnapshot(in context: Context, completion: @escaping (MealEntry) -> Void) {
        Task {
            var currentDate = Date.now
            if currentDate[.hour] >= 20 {
                currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
            }
            do {
                let year = currentDate[.year]
                let month = currentDate[.month]
                let day = currentDate[.day]
                let request = FetchMealRequest(year: year, month: month, day: day)
                let meal = try await mealRepository.fetchMeal(request)
                let entry = MealEntry(
                    date: currentDate,
                    meal: meal
                )
                completion(entry)
            } catch {
                let entry = MealEntry.of(currentDate)
                completion(entry)
            }
        }
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        let nextUpdate = Calendar.current.date(byAdding: .hour, value: 1, to: Date()) ?? .init()
        Task {
            var currentDate = Date()
            // 오후 8시가 지나면 다음날로
            if currentDate[.hour] >= 20 {
                currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
            }
            
            do {
                let meal = try await mealRepository.fetchMeal(
                    .init(
                        year: currentDate[.year],
                        month: currentDate[.month],
                        day: currentDate[.day]
                    )
                )
                let entry = MealEntry(
                    date: currentDate,
                    meal: meal
                )
                let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
                completion(timeline)
            } catch {
                let entry = MealEntry.empty
                let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
                completion(timeline)
            }
        }
    }
}
