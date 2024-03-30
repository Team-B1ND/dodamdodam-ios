//
//  MealViewModel.swift
//  DodamDodam
//
//  Created by 이민규 on 3/19/24.
//

import Combine

class MealViewModel: ObservableObject {
    
    @Published var mealData: [MealResponse]?
}
