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

class HomeViewModel: ObservableObject, OnAppearProtocol {
    
    // MARK: - State
    @Published var mealType: MealType?
    @Published var isShowingAlert: Bool = false
    @Published var ringCount: Int = 0
    
    @Published var bannerData: [BannerResponse]?
    @Published var mealData: MealModel?
    @Published var wakeupSongData: [WakeupSongResponse]?
    @Published var nightStudyData: NightStudyResponse?
    @Published var outGoingData: OutGoingResponse?
    @Published var outSleepingData: OutSleepingResponse?
    @Published var scheduleData: [ScheduleResponse]?
    
    var isFirstOnAppear: Bool = true
    
    // MARK: - Repository
    @Inject var bannerRepository: any BannerRepository
    @Inject var mealRepository: any MealRepository
    @Inject var wakeupSongRepository: any WakeupSongRepository
    @Inject var outGoingRepository: any OutGoingRepository
    @Inject var outSleepingRepository: any OutSleepingRepository
    @Inject var nightStudyRepository: any NightStudyRepository
    @Inject var scheduleRepository: any ScheduleRepository
    
    // MARK: - Method
    @MainActor
    func fetchAllData() async {
        async let fetchBannerData: () = await fetchBannerData()
        async let fetchMealData: () = await fetchMealData()
        async let fetchWakeupSongData: () = await fetchWakeupSongData()
        async let fetchScheduleData: () = await fetchSchedule()
        
        if Sign.isLoggedIn {
            async let fetchOutData: () = await fetchOutData()
            async let fetchNightStudy: () = await fetchNightStudy()
            _ = await [fetchBannerData, fetchMealData, fetchWakeupSongData, fetchOutData, fetchNightStudy, fetchScheduleData]
        } else {
            _ = await [fetchBannerData, fetchMealData, fetchWakeupSongData, fetchScheduleData]
        }
    }
    
    @MainActor
    func onRefresh() async {
        clearData()
        await fetchAllData()
    }
    
    func clearData() {
        bannerData = nil
        mealData = nil
        wakeupSongData = nil
        outGoingData = nil
        outSleepingData = nil
        nightStudyData = nil
        scheduleData = nil
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
        let currentTime = Date.now
        do {
            mealData = try await mealRepository.fetchMeal(
                .init(
                    year: currentTime[.year],
                    month: currentTime[.month],
                    day: currentTime[.day]
                )
            )
        } catch let error {
            print(error)
        }
    }
    
    @MainActor
    func fetchWakeupSongData() async {
        let currentTime = Date.now
        do {
            wakeupSongData = try await wakeupSongRepository.fetchAllowedWakeupSong(
                .init(
                    year: currentTime[.year],
                    month: currentTime[.month],
                    day: currentTime[.day]
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
    
    @MainActor
    func fetchSchedule() async {
        let currentTime = Date.now
        do {
            scheduleData = try await scheduleRepository.fetchScheduleBetween(
                .init(
                    startAt: currentTime.parseString(format: "yyyy-MM-dd"),
                    endAt: Calendar.current.date(byAdding: .month, value: 1, to: currentTime)?.parseString(format: "yyyy-MM-dd") ?? ""
                )
            )
        } catch let error {
            print(error)
        }
    }
}
