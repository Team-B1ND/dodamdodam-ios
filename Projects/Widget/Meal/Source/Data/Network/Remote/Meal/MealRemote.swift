//
//  MealRemote.swift
//  DodamDodam-MealWidget
//
//  Created by Mercen on 4/5/24.
//

struct MealRemote: RemoteProtocol {
    
    typealias Target = MealService
    
    func fetchMonthlyMeal(_ request: FetchMonthlyMealRequest) async throws -> Response<[MealResponse]> {
        try await self.request(target: .fetchMonthlyMeal(request))
            .map(Response<[MealResponse]>.self, using: decoder)
    }
}
