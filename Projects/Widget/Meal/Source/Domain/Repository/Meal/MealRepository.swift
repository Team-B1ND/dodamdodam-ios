//
//  MealRepository.swift
//  DodamDodam-MealWidget
//
//  Created by Mercen on 4/5/24.
//

protocol MealRepository: RepositoryProtocol {
    
    func fetchMonthlyMeal(_ request: FetchMonthlyMealRequest) async throws -> [MealResponse]
}
