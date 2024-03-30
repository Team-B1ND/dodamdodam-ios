//
//  HomeViewModel.swift
//  DodamDodam
//
//  Created by 이민규 on 3/16/24.
//

import Combine

class HomeViewModel: ObservableObject {
    
    @Published var mealIdx: Int = -1
    @Published var bannerData: [BannerResponse]?
    @Published var mealData: MealResponse?
    @Published var nightStudyData: NightStudyResponse?
    @Published var outGoingData: OutGoingResponse?
    @Published var outSleepingData: OutSleepingResponse?
    @Published var scheduleData: [ScheduleResponse]?
    @Published var wakeupSongData: [WakeupSongResponse]?
}
