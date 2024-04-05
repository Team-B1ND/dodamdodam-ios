//
//  Meal.swift
//  DodamDodam-MealWidget
//
//  Created by Mercen on 4/5/24.
//

import RealmSwift

class Meal: Object, Decodable {
    
    @Persisted var details: List<MealMenu>
    @Persisted var calorie: Double
}
