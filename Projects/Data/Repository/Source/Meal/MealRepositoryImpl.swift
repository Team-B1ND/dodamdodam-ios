//
//  MealRepositoryImpl.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import DataSource
import Domain
import Foundation
import Local

public struct MealRepositoryImpl: MealRepository {
    
    let dataSource: MealDataSource
    let localDataSource: LocalMealDataSource
    
    public init(
        dataSource: MealDataSource,
        localDataSource: LocalMealDataSource
    ) {
        self.dataSource = dataSource
        self.localDataSource = localDataSource
    }
    
    public func fetchMeal(_ request: FetchMealRequest) async throws -> MealModel {
        if let cachedMeal = try localDataSource.fetchMeal(request) {
            if cachedMeal.isExpired {
                try localDataSource.deleteAll()
            } else {
                return cachedMeal.toModel()
            }
        }
        
        _ = try await getMonthlyMeals(.init(year: request.year, month: request.month))
        return try await dataSource.fetchMeal(request).toModel()
    }
    
    public func fetchMonthlyMeal(_ request: FetchMonthlyMealRequest) async throws -> [MealModel] {
        let cachedMeals = try localDataSource.fetchMonthlyMeal(request)
        if cachedMeals.contains(where: { $0.isExpired }) {
            try localDataSource.deleteAll()
        } else if !cachedMeals.isEmpty {
            return cachedMeals.map { $0.toModel() }
        }
        
        return try await getMonthlyMeals(request)
    }
    
    private func getMonthlyMeals(_ request: FetchMonthlyMealRequest) async throws -> [MealModel] {
        let meals = try await dataSource.fetchMonthlyMeal(request).map { $0.toModel() }
        try localDataSource.saveMeals(meals: meals.map { MealEntity.from($0) })
        return meals
    }
}
