//
//  MealMenu.swift
//  DodamDodam-MealWidget
//
//  Created by Mercen on 4/5/24.
//

import RealmSwift

class MealMenu: Object, Decodable {
    
    @Persisted var name: String
    @Persisted var allergies: List<Int>
}
