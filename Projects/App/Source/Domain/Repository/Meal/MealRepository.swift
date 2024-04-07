//
//  MealRepository.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

protocol MealRepository: RepositoryProtocol {
    
    func fetchMeal(_ request: FetchMealRequest) async throws -> MealResponse
    
    func fetchMonthlyMeal(_ request: FetchMonthlyMealRequest) async throws -> [MealResponse]
}
