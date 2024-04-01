//
//  HomeViewModel.swift
//  DodamDodam
//
//  Created by 이민규 on 3/16/24.
//

import Combine
import Foundation

class HomeViewModel: ObservableObject {
    
    // MARK: - State
    @Published var mealIdx: Int = -1
    @Published var isShowingAlert: Bool = false
    
    @Published var bannerData: [BannerResponse]?
    @Published var mealData: MealResponse?
    @Published var wakeupSongData: [WakeupSongResponse]?
    @Published var nightStudyData: NightStudyResponse?
    @Published var outGoingData: OutGoingResponse?
    @Published var outSleepingData: OutSleepingResponse?
    @Published var scheduleData: [ScheduleResponse]?
    
    // MARK: - Repository
    @Inject var bannerRepository: any BannerRepository
    @Inject var mealRepository: any MealRepository
    @Inject var wakeupSongRepository: any WakeupSongRepository
    
    // MARK: - Method
    @MainActor
    func onAppear() async {
        await fetchBannerData()
        await fetchMaelData()
        await fetchWakeupSongData()
    }
    
    @MainActor
    func fetchBannerData() async {
        
        do {
            bannerData = try await bannerRepository.fetchActiveBanner()
        } catch let error {
            print(error)
        }
    }
    
    @MainActor
    func fetchMaelData() async {
        
        do {
            mealData = try await mealRepository.fetchMeal(
                .init(
                    year: getDate(.year),
                    month: getDate(.month),
                    day: getDate(.day)
                )
            )
        } catch let error {
            print(error)
        }
    }
    
    @MainActor
    func fetchWakeupSongData() async {
        
        do {
            wakeupSongData = try await wakeupSongRepository.fetchAllowedWakeupSong(
                .init(
                    year: getDate(.year),
                    month: getDate(.month),
                    day: getDate(.day) + 1
                )
            )
        } catch let error {
            print(error)
        }
    }
    
    func getDate(_ type: DateType) -> Int {
        let currentDate = Date()
        let calendar = Calendar.current
        
        let year = calendar.component(.year, from: currentDate)
        let month = calendar.component(.month, from: currentDate)
        let day = calendar.component(.day, from: currentDate)
        
        switch type {
        case .year:
            return year
        case .month:
            return month
        case .day:
            return day
        }
    }
}

enum DateType: Int {
    case year = 0
    case month = 1
    case day = 2
}
