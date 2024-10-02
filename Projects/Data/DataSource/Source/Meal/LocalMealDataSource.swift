//
//  LocalMealDataSource.swift
//  DataSource
//
//  Created by hhhello0507 on 9/17/24.
//

import Foundation
import Domain
import Local

public struct LocalMealDataSource: DataSourceProtocol {
    
    let mealCache: MealCache
    
    public init(mealCache: MealCache) {
        self.mealCache = mealCache
    }
    
    public func fetchMeal(_ request: FetchMealRequest) throws -> MealEntity? {
        return try mealCache.fetchMeal(request)
    }
    
    public func fetchMonthlyMeal(_ request: FetchMonthlyMealRequest) throws -> [MealEntity] {
        return try mealCache.fetchMonthlyMeal(request)
    }
    
    public func saveMeal(meal: MealEntity) throws {
        try mealCache.saveMeal(meal: meal)
    }
    
    public func saveMeals(meals: [MealEntity]) throws {
        try mealCache.saveMeals(meals: meals)
    }
    
    public func deleteAll() throws {
        try mealCache.deleteAll()
    }
}
