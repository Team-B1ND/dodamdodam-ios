//
//  MealRepositoryImpl.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import DataSource
import Domain
import SwiftBok

@Init()
public struct MealRepositoryImpl: MealRepository {
    
    let dataSource: MealDataSource
    
    public func fetchMeal(_ request: FetchMealRequest) async throws -> MealResponse {
        try await dataSource.fetchMeal(request)
    }
    
    public func fetchMonthlyMeal(_ request: FetchMonthlyMealRequest) async throws -> [MealResponse] {
        try await dataSource.fetchMonthlyMeal(request)
    }
}
