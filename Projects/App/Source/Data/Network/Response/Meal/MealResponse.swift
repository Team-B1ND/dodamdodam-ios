//
//  MealResponse.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

import Foundation

struct MealResponse: ResponseProtocol {
    
    let exists: Bool
    let date: Date
    let breakfast, lunch, dinner: Meal?
}
