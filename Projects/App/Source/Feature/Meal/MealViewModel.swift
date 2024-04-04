//
//  MealViewModel.swift
//  DodamDodam
//
//  Created by 이민규 on 3/19/24.
//

import Combine

class MealViewModel: ObservableObject {
    
    // MARK: - State
    @Published var isFirstLoad: Bool = true
    @Published var mealData: [MealResponse]?
    
    // MARK: - Repository
    @Inject var mealRepository: any MealRepository
    
    // MARK: - Method
    @MainActor
    func onAppear() async {
        await fetchMealData()
        isFirstLoad = false
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
        do {
            mealData = try await mealRepository.fetchMonthlyMeal(
                .init(
                    year: getDate(.year),
                    month: getDate(.month)
                )
            )
        } catch let error {
            print(error)
        }
    }
}
