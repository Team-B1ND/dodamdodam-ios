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
    @Published var dialogMessage = "" {
        didSet {
            showDialog = true
        }
    }
    @Published var showDialog = false
    
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
    func fetchWakeupSongByKeyword(keyword: String) async {
        
        isSearchLoading = true
        do {
            wakeupSongSearchData = try await wakeupSongRepository.fetchWakeupSongByKeyword(
                .init(keyword: keyword)
            )
            isSearchLoading = false
        } catch let error {
            print(error)
            isSearchLoading = false
            dialogMessage = "기상송 검색을 실패했어요"
        }
    }
    
    @MainActor
    func postWakeupSongByKeyword(artist: String, title: String) async {
        
        do {
            try await wakeupSongRepository.postWakeupSongByKeyword(
                .init(artist: artist, title: title)
            )
            dialogMessage = "기상송 신청에 성공했어요"
        } catch let error {
            print(error)
            dialogMessage = "기상송을 이미 신청했어요"
        }
    }
    
    @MainActor
    func postWakeupSong(videoUrl: String) async {
        
        do {
            try await wakeupSongRepository.postWakeupSong(
                .init(videoUrl: videoUrl)
            )
            dialogMessage = "기상송 신청에 성공했어요"
        } catch let error {
            print(error)
            dialogMessage = "기상송을 이미 신청했어요"
        }
    }
}
