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
    @Published var ringCount: Int = 0
    
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
                    day: getDate(.day)
                )
            )
        } catch let error {
            print(error)
        }
    }
}
