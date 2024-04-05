//
//  MealDatabase.swift
//  DodamDodam-MealWidget
//
//  Created by Mercen on 4/5/24.
//

import Foundation
import RealmSwift

struct MealDatabase {
    
    let realm: Realm = try! Realm()
    
    func selectAllMeal(date: String) -> [MealData] {
        let objects = realm.objects(MealData.self)
        let query = "date == \"\(date)\""
        return Array(objects.filter(query))
    }
}
