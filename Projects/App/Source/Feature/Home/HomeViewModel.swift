//
//  HomeViewModel.swift
//  DodamDodam
//
//  Created by 이민규 on 3/16/24.
//

import Combine

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
    
    // MARK: - Method
    @MainActor
    func onAppear() async {
        await fetchBannerData()
    }
    
    @MainActor
    func fetchBannerData() async {
        
        do {
            bannerData = try await bannerRepository.fetchActiveBanner()
        } catch let error {
            print(error)
        }
    }
}
