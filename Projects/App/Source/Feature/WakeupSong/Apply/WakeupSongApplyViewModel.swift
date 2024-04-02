//
//  WakeupSongApplyViewModel.swift
//  DodamDodam
//
//  Created by dgsw8th71 on 4/1/24.
//

import Foundation

class WakeupSongApplyViewModel: ObservableObject {
    
    // MARK: - State
    @Published var keywordText: String = ""
    @Published var wakeupSongChartData: [WakeupSongChartResponse]?
    @Published var wakeupSongSearchData: [WakeupSongSearchResponse]?
    
    @Published var isSearchLoading: Bool = false
    @Published var isFailedPostWakeupSongByKeyword: Bool = false
    
    // MARK: - Repository
    @Inject var wakeupSongRepository: any WakeupSongRepository
    
    // MARK: - Method
    @MainActor
    func onAppear() async {
        
        keywordText = ""
        wakeupSongSearchData = nil
        await fetchWakeupSongChart()
    }
    
    @MainActor
    func fetchWakeupSongChart() async {
        
        do {
            wakeupSongChartData = try await wakeupSongRepository.fetchWakeupSongChart()
        } catch let error {
            print("fetchWakeupSongChart:\n\(error)")
        }
        isSearchLoading = false
    }
    
    @MainActor
    func fetchWakeupSongChart(keyword: String) async {
        
        isSearchLoading = true
        do {
            wakeupSongSearchData = try await wakeupSongRepository.fetchWakeupSongByKeyword(
                .init(keyword: keyword)
            )
            isSearchLoading = false
        } catch let error {
            print(error)
            isSearchLoading = false
        }
    }
    
    func postWakeupSongByKeyword(artist: String, title: String) async {
        
        do {
            _ = try await wakeupSongRepository.postWakeupSongByKeyword(
                .init(artist: artist, title: title)
            )
        } catch let error {
            print(error)
        }
    }
}
