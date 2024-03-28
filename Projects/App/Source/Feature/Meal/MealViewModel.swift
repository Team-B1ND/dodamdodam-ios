//
//  MealViewModel.swift
//  DodamDodam
//
//  Created by 이민규 on 3/19/24.
//

import Combine

class MealViewModel: ObservableObject {
    
    @Published var mealDatas: [MealData]? = [
        MealData(
            exists: true,
            date: "2024-03-20",
            breakfast: Meal(
                details: [
                    MealMenu(name: "전복죽", allergies: [18]),
                    MealMenu(name: "모닝빵/버터/딸기잼", allergies: [1, 2, 5, 6, 13]),
                    MealMenu(name: "샐러드바/드레싱", allergies: [1, 2, 5, 6, 12]),
                    MealMenu(name: "나박김치", allergies: [9]),
                    MealMenu(name: "시리얼(콘앤스위트)&우유", allergies: [2, 5, 6])
                ], calorie: 647.7),
            lunch: Meal(
                details: [
                    MealMenu(
                        name: "흑미밥", allergies: []),
                    MealMenu(name: "왕만두육개장", allergies: [1, 5, 6, 10, 16, 18]),
                    MealMenu(name: "고등어무조림", allergies: [5, 6, 7, 13]),
                    MealMenu(name: "취나물무침", allergies: [5, 6]),
                    MealMenu(name: "배추김치", allergies: [9]),
                    MealMenu(name: "롤링핫도그", allergies: [1, 2, 5, 6, 10, 12, 15, 18])
                ], calorie: 945.5),
            dinner: Meal(
                details: [
                    MealMenu(name: "혼합잡곡밥(10곡)", allergies: [5]),
                    MealMenu(name: "손수제비국", allergies: [5, 6, 9]),
                    MealMenu(name: "묵은지김치찜", allergies: [5, 6, 9, 10, 13]),
                    MealMenu(name: "동태전", allergies: [1, 5, 6, 13]),
                    MealMenu(name: "배추김치", allergies: [9]),
                    MealMenu(name: "주스", allergies: [13])
                ], calorie: 1114.4)),
        MealData(
            exists: true,
            date: "2024-03-21",
            breakfast: Meal(
                details: [
                    MealMenu(name: "전복죽", allergies: [18]),
                    MealMenu(name: "모닝빵/버터/딸기잼", allergies: [1, 2, 5, 6, 13]),
                    MealMenu(name: "샐러드바/드레싱", allergies: [1, 2, 5, 6, 12]),
                    MealMenu(name: "나박김치", allergies: [9]),
                    MealMenu(name: "시리얼(콘앤스위트)&우유", allergies: [2, 5, 6])
                ], calorie: 647.7),
            lunch: Meal(
                details: [
                    MealMenu(
                        name: "흑미밥", allergies: []),
                    MealMenu(name: "왕만두육개장", allergies: [1, 5, 6, 10, 16, 18]),
                    MealMenu(name: "고등어무조림", allergies: [5, 6, 7, 13]),
                    MealMenu(name: "취나물무침", allergies: [5, 6]),
                    MealMenu(name: "배추김치", allergies: [9]),
                    MealMenu(name: "롤링핫도그", allergies: [1, 2, 5, 6, 10, 12, 15, 18])
                ], calorie: 945.5),
            dinner: Meal(
                details: [
                    MealMenu(name: "혼합잡곡밥(10곡)", allergies: [5]),
                    MealMenu(name: "손수제비국", allergies: [5, 6, 9]),
                    MealMenu(name: "묵은지김치찜", allergies: [5, 6, 9, 10, 13]),
                    MealMenu(name: "동태전", allergies: [1, 5, 6, 13]),
                    MealMenu(name: "배추김치", allergies: [9]),
                    MealMenu(name: "주스", allergies: [13])
                ], calorie: 1114.4)
        ),
        MealData(
            exists: true,
            date: "2024-03-22",
            breakfast: Meal(
                details: [
                    MealMenu(name: "전복죽", allergies: [18]),
                    MealMenu(name: "모닝빵/버터/딸기잼", allergies: [1, 2, 5, 6, 13]),
                    MealMenu(name: "샐러드바/드레싱", allergies: [1, 2, 5, 6, 12]),
                    MealMenu(name: "나박김치", allergies: [9]),
                    MealMenu(name: "시리얼(콘앤스위트)&우유", allergies: [2, 5, 6])
                ], calorie: 647.7),
            lunch: nil,
            dinner: nil
        ),
        MealData(
            exists: false,
            date: "2024-03-29",
            breakfast: nil,
            lunch: nil,
            dinner: nil
        )
    ]
}
