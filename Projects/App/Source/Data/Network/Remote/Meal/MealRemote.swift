//
//  MealRemote.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Foundation

struct MealRemote: RemoteProtocol {
    
    typealias Target = MealService
    
    func fetchMeal(_ request: FetchMealRequest) async throws -> Response<MealResponse> {
        try await self.request(target: .fetchMeal(request))
            .map(Response<MealResponse>.self, using: decoder)
    }
    
    func fetchMonthlyMeal(_ request: FetchMonthlyMealRequest) async throws -> Response<[MealResponse]> {
        try await self.request(target: .fetchMonthlyMeal(request))
            .map(Response<[MealResponse]>.self, using: decoder)
    }
}
