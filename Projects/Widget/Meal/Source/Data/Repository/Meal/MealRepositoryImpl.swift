//
//  MealRepositoryImpl.swift
//  DodamDodam-MealWidget
//
//  Created by Mercen on 4/5/24.
//

struct MealRepositoryImpl: MealRepository {
    
    let dataSource: MealDataSource
    
    func fetchMonthlyMeal(_ request: FetchMonthlyMealRequest) async throws -> [MealResponse] {
        try await dataSource.fetchMonthlyMeal(request)
    }
}
