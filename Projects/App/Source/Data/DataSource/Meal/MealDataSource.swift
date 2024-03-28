//
//  MealDataSource.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

struct MealDataSource: DataSourceProtocol {
    
    let remote: MealRemote
    
    func fetchMeal(_ request: FetchMealRequest) async throws -> MealResponse {
        let response = try await remote.fetchMeal(request)
        return response.data
    }
    
    func fetchMonthlyMeal(_ request: FetchMonthlyMealRequest) async throws -> [MealResponse] {
        let response = try await remote.fetchMonthlyMeal(request)
        return response.data
    }
}
