//
//  MealData.swift
//  DodamDodam-MealWidget
//
//  Created by Mercen on 4/5/24.
//

import RealmSwift

class MealData: Object, Decodable {
    
    @Persisted var exists: Bool
    @Persisted var date: String
    @Persisted var breakfast: Meal?
    @Persisted var lunch: Meal?
    @Persisted var dinner: Meal?
}
