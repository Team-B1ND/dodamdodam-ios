//
//  MealViewModel.swift
//  DodamDodam
//
//  Created by 이민규 on 3/19/24.
//

import Combine

class MealViewModel: ObservableObject {
    
    @Published var mealDatas: [Meal]? = [
        Meal(
            exists: true,
            date: "2024-03-26",
            breakfast: MealDetails(
                details: [
                    MealItem(name: "전복죽", allergies: [18]),
                    MealItem(name: "모닝빵/버터/딸기잼", allergies: [1, 2, 5, 6, 13]),
                    MealItem(name: "샐러드바/드레싱", allergies: [1, 2, 5, 6, 12]),
                    MealItem(name: "나박김치", allergies: [9]),
                    MealItem(name: "시리얼(콘앤스위트)&우유", allergies: [2, 5, 6])
                ], calorie: 647.7),
            lunch: MealDetails(
                details: [
                    MealItem(
                        name: "흑미밥", allergies: []),
                    MealItem(name: "왕만두육개장", allergies: [1, 5, 6, 10, 16, 18]),
                    MealItem(name: "고등어무조림", allergies: [5, 6, 7, 13]),
                    MealItem(name: "취나물무침", allergies: [5, 6]),
                    MealItem(name: "배추김치", allergies: [9]),
                    MealItem(name: "롤링핫도그", allergies: [1, 2, 5, 6, 10, 12, 15, 18])
                ], calorie: 945.5),
            dinner: MealDetails(
                details: [
                    MealItem(name: "혼합잡곡밥(10곡)", allergies: [5]),
                    MealItem(name: "손수제비국", allergies: [5, 6, 9]),
                    MealItem(name: "묵은지김치찜", allergies: [5, 6, 9, 10, 13]),
                    MealItem(name: "동태전", allergies: [1, 5, 6, 13]),
                    MealItem(name: "배추김치", allergies: [9]),
                    MealItem(name: "주스", allergies: [13])
                ], calorie: 1114.4)),
        Meal(
            exists: true,
            date: "2024-03-27",
            breakfast: MealDetails(
                details: [
                    MealItem(name: "전복죽", allergies: [18]),
                    MealItem(name: "모닝빵/버터/딸기잼", allergies: [1, 2, 5, 6, 13]),
                    MealItem(name: "샐러드바/드레싱", allergies: [1, 2, 5, 6, 12]),
                    MealItem(name: "나박김치", allergies: [9]),
                    MealItem(name: "시리얼(콘앤스위트)&우유", allergies: [2, 5, 6])
                ], calorie: 647.7),
            lunch: MealDetails(
                details: [
                    MealItem(
                        name: "흑미밥", allergies: []),
                    MealItem(name: "왕만두육개장", allergies: [1, 5, 6, 10, 16, 18]),
                    MealItem(name: "고등어무조림", allergies: [5, 6, 7, 13]),
                    MealItem(name: "취나물무침", allergies: [5, 6]),
                    MealItem(name: "배추김치", allergies: [9]),
                    MealItem(name: "롤링핫도그", allergies: [1, 2, 5, 6, 10, 12, 15, 18])
                ], calorie: 945.5),
            dinner: MealDetails(
                details: [
                    MealItem(name: "혼합잡곡밥(10곡)", allergies: [5]),
                    MealItem(name: "손수제비국", allergies: [5, 6, 9]),
                    MealItem(name: "묵은지김치찜", allergies: [5, 6, 9, 10, 13]),
                    MealItem(name: "동태전", allergies: [1, 5, 6, 13]),
                    MealItem(name: "배추김치", allergies: [9]),
                    MealItem(name: "주스", allergies: [13])
                ], calorie: 1114.4)
        ),
        Meal(
            exists: true,
            date: "2024-03-28",
            breakfast: MealDetails(
                details: [
                    MealItem(name: "전복죽", allergies: [18]),
                    MealItem(name: "모닝빵/버터/딸기잼", allergies: [1, 2, 5, 6, 13]),
                    MealItem(name: "샐러드바/드레싱", allergies: [1, 2, 5, 6, 12]),
                    MealItem(name: "나박김치", allergies: [9]),
                    MealItem(name: "시리얼(콘앤스위트)&우유", allergies: [2, 5, 6])
                ], calorie: 647.7),
            lunch: nil,
            dinner: nil
        ),
        Meal(
            exists: false,
            date: "2024-03-29",
            breakfast: nil,
            lunch: nil,
            dinner: nil
        )
    ]
}
