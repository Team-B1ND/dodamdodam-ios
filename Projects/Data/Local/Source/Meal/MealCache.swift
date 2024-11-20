//
//  MealRealm.swift
//  Local
//
//  Created by hhhello0507 on 9/17/24.
//

import Foundation
import Domain
import RealmSwift
import Shared

public struct MealCache {
    public init() {}
    public func fetchMeal(_ request: FetchMealRequest) throws -> MealEntity? {
        let realm = try Realm()
        return realm.objects(MealEntity.self)
            .filter {
                $0.date[.year] == request.year
                && $0.date[.month] == request.month
                && $0.date[.day] == request.day
            }
            .first
    }
    
    public func fetchMonthlyMeal(_ request: FetchMonthlyMealRequest) throws -> [MealEntity] {
        let realm = try Realm()
        return realm.objects(MealEntity.self)
            .filter {
                $0.date[.year] == request.year
                && $0.date[.month] == request.month
            }
    }
    
    public func saveMeal(meal: MealEntity) throws {
        let realm = try Realm()
        
        // N+1 문제..? 🤔
        // date 중복이 없을 경우
        guard realm.objects(MealEntity.self)
            .filter({ $0.date.equals(meal.date, components: [.day, .month]) })
            .first == nil else {
            return
        }
        
        try realm.safeWrite {
            realm.add(meal, update: .all)
        }
    }
    
    public func saveMeals(meals: [MealEntity]) throws {
        let realm = try Realm()
        let cachedMeals = realm.objects(MealEntity.self).toArray()
        
        // date 중복이 없는 것들만
        let saveMeals = meals.filter { meal in
            !cachedMeals.contains { cachedMeal in
                cachedMeal.date.equals(meal.date, components: [.day, .month])
            }
        }
        try realm.safeWrite {
            realm.add(saveMeals, update: .all)
        }
    }
    
    public func deleteAll() throws {
        let realm = try Realm()
        let meals = realm.objects(MealEntity.self)
        try realm.safeWrite {
            realm.delete(meals)
        }
    }
}
