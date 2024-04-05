//
//  MealResponse.swift
//  DodamDodam-MealWidget
//
//  Created by Mercen on 4/5/24.
//

struct MealResponse: ResponseProtocol {
    
    let exists: Bool
    let date: String
    let breakfast, lunch, dinner: Meal?
}
