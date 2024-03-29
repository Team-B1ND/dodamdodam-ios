//
//  MealRepositoryImpl.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

struct MealRepositoryImpl: MealRepository {
    
    let dataSource: MealDataSource
    
    func fetchMeal(_ request: FetchMealRequest) async throws -> MealResponse {
        try await dataSource.fetchMeal(request)
    }
    
    func fetchMonthlyMeal(_ request: FetchMonthlyMealRequest) async throws -> [MealResponse] {
        try await dataSource.fetchMonthlyMeal(request)
    }
}
