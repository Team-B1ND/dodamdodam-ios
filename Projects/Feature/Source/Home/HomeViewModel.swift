//
//  HomeViewModel.swift
//  DodamDodam
//
//  Created by 이민규 on 3/16/24.
//

import Foundation
import SignKit
import DIContainer
import Domain
import Shared

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
    @Inject var outGoingRepository: any OutGoingRepository
    @Inject var outSleepingRepository: any OutSleepingRepository
    @Inject var nightStudyRepository: any NightStudyRepository
    
    // MARK: - Method
    @MainActor
    func onAppear() async {
        async let fetchBannerData: () = await fetchBannerData()
        async let fetchMealData: () = await fetchMealData()
        async let fetchWakeupSongData: () = await fetchWakeupSongData()
        
        if Sign.isLoggedIn {
            async let fetchOutData: () = await fetchOutData()
            async let fetchNightStudy: () = await fetchNightStudy()
            _ = await [fetchBannerData, fetchMealData, fetchWakeupSongData, fetchOutData, fetchNightStudy]
        } else {
            _ = await [fetchBannerData, fetchMealData, fetchWakeupSongData]
        }
    }
    
    @MainActor
    func onRefresh() async {
        clearData()
        await onAppear()
    }
    
    func clearData() {
        bannerData = nil
        mealData = nil
        wakeupSongData = nil
        outGoingData = nil
        outSleepingData = nil
        nightStudyData = nil
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
    func fetchMealData() async {
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
    
    @MainActor
    func fetchOutData() async {
        async let fetchOutGoingData: () = fetchOutGoingData()
        async let fetchOutSleepingData: () = fetchOutSleepingData()
        _ = await [fetchOutGoingData, fetchOutSleepingData]
    }
    
    @MainActor
    private func fetchOutSleepingData() async {
        do {
            let outSleepingResponse = try await outSleepingRepository.fetchOutSleeping()
            guard let earliestOutSleepingResponse = outSleepingResponse.min(by: {
                $0.startAt < $1.startAt
            }) else {
                outSleepingData = .none
                return
            }
            outSleepingData = earliestOutSleepingResponse
        } catch {
            print(error)
        }
    }
    
    @MainActor
    private func fetchOutGoingData() async {
        do {
            let outGoingResponse = try await outGoingRepository.fetchOutGoing()
            guard let earliestOutGoingResponse = outGoingResponse.min(by: {
                $0.startAt < $1.startAt
            }) else {
                outGoingData = .none
                return
            }
            outGoingData = earliestOutGoingResponse
        } catch {
            print(error)
        }
    }
    
    @MainActor
    func fetchNightStudy() async {
        do {
            let response = try await nightStudyRepository.fetchNightStudy()
            guard let earliestResponse = response.min(by: {
                $0.startAt < $1.startAt
            }) else {
                nightStudyData = .none
                return
            }
            nightStudyData = earliestResponse
        } catch let error {
            print(error)
        }
    }
}
