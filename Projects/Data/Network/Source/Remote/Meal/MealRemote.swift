//
//  MealRemote.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Domain

public struct MealRemote: RemoteProtocol {
    
    typealias Target = MealService
    
    public init() {}
    
    public func fetchMeal(_ request: FetchMealRequest) async throws -> Response<MealResponse> {
        try await self.request(target: .fetchMeal(request), res: MealResponse.self)
    }
    
    public func fetchMonthlyMeal(_ request: FetchMonthlyMealRequest) async throws -> Response<[MealResponse]> {
        try await self.request(target: .fetchMonthlyMeal(request), res: [MealResponse].self)
    }
}
