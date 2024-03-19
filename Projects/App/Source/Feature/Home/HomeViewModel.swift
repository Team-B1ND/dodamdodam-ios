//
//  HomeViewModel.swift
//  DodamDodam
//
//  Created by 이민규 on 3/16/24.
//

import Combine

class HomeViewModel: ObservableObject {
    
    @Published var mealIdx: Int = -1
    @Published var bannerData: [Banner]?
    @Published var mealData: Meal? = Meal(
        exists: true,
        date: "2024-03-07",
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
            ], calorie: 1114.4))
    @Published var nightStudyData: NightStudy?
    @Published var outData: Out?
    @Published var scheduleData: [Schedule]?
    @Published var wakeupSongData: [WakeupSong]?
}

public struct Banner: Codable, Hashable {
    let id: Int
    let expireA, imageUrl, redirectUrl, title: String
    let status: String
}

public struct Meal: Codable, Hashable {
    let exists: Bool
    let date: String
    let breakfast: MealDetails
    let lunch: MealDetails
    let dinner: MealDetails
}

public struct MealDetails: Codable, Hashable {
    let details: [MealItem]
    let calorie: Double
}

public struct MealItem: Codable, Hashable {
    let name: String
    let allergies: [Int]
}

public struct NightStudy: Codable, Hashable {
    let id: Int
    let content, status: String
    let doNeedPhone: Bool
    let reasonForPhone: String
    let student: Student
    let place: String
    let startAt, endAt, createdAt, modifiedAt: String
}

public struct Out: Codable, Hashable {
    let id: Int
    let reason, status: String
    let student: Student
    let startAt, endAt, createdAt, modifiedAt: String
}

public struct Student: Codable, Hashable {
    let id, grade, room, number: Int
    let name: String
}

public struct Schedule: Codable, Hashable {
    let id: Int
    let name: String
    let place: String
    let type: String
    let startDate: String
    let endDate: String
    let targetGrades: [String]
}

public struct WakeupSong: Codable, Hashable {
    let id: Int
    let thumbnailUrl: String
    let videoTitle: String
    let videoId: String
    let videoUrl: String
    let channelTitle: String
    let status: String
    let createdAt: String
}
