//
//  MealDataSource.swift
//  DodamDodam-MealWidget
//
//  Created by Mercen on 4/5/24.
//

struct MealDataSource: DataSourceProtocol {
    
    let remote: MealRemote
    
    func fetchMonthlyMeal(_ request: FetchMonthlyMealRequest) async throws -> [MealResponse] {
        let response = try await remote.fetchMonthlyMeal(request)
        return response.data
    }
}
