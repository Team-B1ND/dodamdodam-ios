//
//  MealViewModel.swift
//  DodamDodam
//
//  Created by 이민규 on 3/19/24.
//

import Combine
import Domain
import DIContainer
import Shared
import Foundation

class MealViewModel: ObservableObject {
    
    // MARK: - State
    @Published var mealData: [MealModel]?
    @Published var selectedDate: Date = .now
    var selectedMeal: MealModel? {
        mealData?.first {
            $0.date.equals(selectedDate, components: [.year, .month, .day])
        }
    }
    @Published var selectedCalendar: Date = .now
    
    // MARK: - Repository
    @Inject var mealRepository: any MealRepository
    
    // MARK: - Method
    @MainActor
    func onAppear() async {
        await fetchMealData()
    }
    
    @MainActor
    func onRefresh() async {
        clearData()
        await onAppear()
    }
    
    func clearData() {
        mealData = nil
    }
    
    @MainActor
    func fetchMealData() async {
        let currentTime = Date.now
        do {
            mealData = try await mealRepository.fetchMonthlyMeal(
                .init(
                    year: currentTime[.year],
                    month: currentTime[.month]
                )
            )
        } catch let error {
            print(error)
        }
    }
}
