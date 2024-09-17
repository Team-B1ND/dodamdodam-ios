//
//  MealRepositoryImpl.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import DataSource
import Domain

public struct MealRepositoryImpl: MealRepository {
    
    let dataSource: MealDataSource
    
    public init(dataSource: MealDataSource) {
        self.dataSource = dataSource
    }
    
    public func fetchMeal(_ request: FetchMealRequest) async throws -> MealModel {
        try await dataSource.fetchMeal(request).toModel()
    }
    
    public func fetchMonthlyMeal(_ request: FetchMonthlyMealRequest) async throws -> [MealModel] {
        try await dataSource.fetchMonthlyMeal(request).map { $0.toModel() }
    }
}
