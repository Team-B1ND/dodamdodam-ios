//
//  WakeupSongViewModel.swift
//  DodamDodam
//
//  Created by dgsw8th71 on 4/1/24.
//

import Foundation
import SignKit
import Domain
import DIContainer
import Shared

class WakeupSongViewModel: ObservableObject {
    
    // MARK: - State
    @Published var allowedWakeupSongData: [WakeupSongResponse]?
    @Published var pendingWakeupSongData: [WakeupSongResponse]?
    @Published var myWakeupSongData: [WakeupSongResponse]?
    
    // MARK: - Repository
    @Inject var wakeupSongRepository: any WakeupSongRepository
    
    // MARK: - Method
    @MainActor
    func onAppear() async {
        async let fetchAllowedWakeupSong: () = await fetchAllowedWakeupSong()
        async let fetchPendingWakeupSong: () = await fetchPendingWakeupSong()
        _ = await [fetchAllowedWakeupSong, fetchPendingWakeupSong]
        if Sign.isLoggedIn {
            await fetchMyWakeupSong()
        }
    }
    
    @MainActor
    func onRefresh() async {
        clearData()
        await onAppear()
    }
    
    func clearData() {
        allowedWakeupSongData = nil
        pendingWakeupSongData = nil
        myWakeupSongData = nil
    }
    
    @MainActor
    func fetchAllowedWakeupSong() async {
        let currentTime = Date.now
        do {
            allowedWakeupSongData = try await wakeupSongRepository.fetchAllowedWakeupSong(
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
    func fetchPendingWakeupSong() async {
        do {
            pendingWakeupSongData = try await wakeupSongRepository.fetchPendingWakeupSong()
        } catch let error {
            print(error)
        }
    }
    
    @MainActor
    func fetchMyWakeupSong() async {
        do {
            myWakeupSongData = try await wakeupSongRepository.fetchWakeupSong()
        } catch let error {
            print(error)
        }
    }
    
    @MainActor
    func deleteWakeupSong(id: Int) async {
        do {
            try await wakeupSongRepository.deleteWakeupSong(id: id)
        } catch let error {
            print(error)
        }
    }
}
