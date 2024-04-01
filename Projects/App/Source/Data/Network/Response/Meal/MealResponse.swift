//
//  MealResponse.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

struct MealResponse: ResponseProtocol {
    
    let exists: Bool
    let date: String
    let breakfast, lunch, dinner: Meal?
}
