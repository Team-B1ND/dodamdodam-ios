//
//  MealDataSource.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Network
import Domain
import SwiftBok

@Init()
public struct MealDataSource: DataSourceProtocol {
    
    let remote: MealRemote
    
    public func fetchMeal(_ request: FetchMealRequest) async throws -> MealResponse {
        let response = try await remote.fetchMeal(request)
        return response.data
    }
    
    public func fetchMonthlyMeal(_ request: FetchMonthlyMealRequest) async throws -> [MealResponse] {
        let response = try await remote.fetchMonthlyMeal(request)
        return response.data
    }
}
