//
//  MealRepository.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

public protocol MealRepository: RepositoryProtocol {
    
    func fetchMeal(_ request: FetchMealRequest) async throws -> MealModel
    
    func fetchMonthlyMeal(_ request: FetchMonthlyMealRequest) async throws -> [MealModel]
}
