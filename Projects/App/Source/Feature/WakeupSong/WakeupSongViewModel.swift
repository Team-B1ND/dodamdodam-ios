//
//  WakeupSongViewModel.swift
//  DodamDodam
//
//  Created by dgsw8th71 on 4/1/24.
//

import Foundation
import SignKit

class WakeupSongViewModel: ObservableObject {
    
    // MARK: - State
    @Published var allowedWakeupSongData: [WakeupSongResponse]?
    @Published var pendingWakeupSongData: [WakeupSongResponse]?
    @Published var myWakeupSongData: [WakeupSongResponse]?
    
    @Published var showDialog = false
    
    // MARK: - Repository
    @Inject var wakeupSongRepository: any WakeupSongRepository
    
    // MARK: - Method
    @MainActor
    func onAppear() async {
        await fetchAllowedWakeupSong()
        await fetchPendingWakeupSong()
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
        do {
            allowedWakeupSongData = try await wakeupSongRepository.fetchAllowedWakeupSong(
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
