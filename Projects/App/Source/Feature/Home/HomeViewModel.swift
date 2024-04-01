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
    @Published var nightStudyData: NightStudyResponse?
    @Published var outGoingData: OutGoingResponse?
    @Published var outSleepingData: OutSleepingResponse?
    @Published var scheduleData: [ScheduleResponse]?
    @Published var wakeupSongData: [WakeupSongResponse]?
    
    // MARK: - Repository
    @Inject var bannerRepository: any BannerRepository
    @Inject var mealRepository: any MealRepository
    
    // MARK: - Method
    @MainActor
    func onAppear() async {
        await fetchBannerData()
        await fetchMaelData()
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
        
        let currentDate = Date()
        let calendar = Calendar.current

        let year = calendar.component(.year, from: currentDate)
        let month = calendar.component(.month, from: currentDate)
        let day = calendar.component(.day, from: currentDate)
        do {
            mealData = try await mealRepository.fetchMeal(
                .init(year: year, month: month, day: day)
            )
        } catch let error {
            print(error)
        }
    }
}
