//
//  MealResponse.swift
//  DodamDodam
//
//  Created by Mercen on 3/27/24.
//

import Foundation
import SwiftBok

@Init()
@Members()
public struct MealResponse: ResponseProtocol {
    
    public let exists: Bool
    public let date: Date
    public let breakfast: Meal?
    public let lunch: Meal?
    public let dinner: Meal?
}
