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
    @Published var mealData: MealData?
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

public struct MealData: Codable, Hashable {
    let exists: Bool
    let date: String
    let breakfast: Meal?
    let lunch: Meal?
    let dinner: Meal?
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
