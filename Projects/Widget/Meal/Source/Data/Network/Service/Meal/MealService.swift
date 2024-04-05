//
//  MealService.swift
//  DodamDodam-MealWidget
//
//  Created by Mercen on 4/5/24.
//

import Moya

enum MealService: ServiceProtocol {
    
    case fetchMonthlyMeal(_ request: FetchMonthlyMealRequest)
}

extension MealService {
    
    var host: String {
        "meal"
    }
    
    var path: String {
        switch self {
        case .fetchMonthlyMeal: "/month"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchMonthlyMeal: .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case let .fetchMonthlyMeal(request):
            request.toURLParameters()
        }
    }
}
