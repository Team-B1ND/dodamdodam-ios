//
//  WakeupSongViewModel.swift
//  DodamDodam
//
//  Created by dgsw8th71 on 4/1/24.
//

import Foundation

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
        
        await fetchAllowedWakeupSong()
        await fetchPendingWakeupSong()
        await fetchMyWakeupSong()
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
