//
//  MealService.swift
//  DodamDodam
//
//  Created by Mercen on 3/14/24.
//

import Moya

enum MealService: ServiceProtocol {
    
    case fetchMeal(_ request: FetchMealRequest)
    case fetchMonthlyMeal(_ request: FetchMonthlyMealRequest)
}

extension MealService {
    
    var host: String {
        "meal"
    }
    
    var path: String {
        switch self {
        case .fetchMeal: ""
        case .fetchMonthlyMeal: "/month"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchMeal: .get
        case .fetchMonthlyMeal: .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case let .fetchMeal(request):
            request.toURLParameters()
        case let .fetchMonthlyMeal(request):
            request.toURLParameters()
        }
    }
}
