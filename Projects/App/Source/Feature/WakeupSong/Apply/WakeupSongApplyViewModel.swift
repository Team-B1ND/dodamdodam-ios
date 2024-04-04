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
    
    @Published var videoUrl: String = ""
    @Published var title: String = ""
    @Published var artist: String = ""
    @Published var isSearchLoading: Bool = false
    
    @Published var showDialog = false
    @Published var dialogMessage = "" {
        didSet {
            showDialog = true
        }
    }
    @Published var showErrorDialog = false
    @Published var dialogErrorMessage = "" {
        didSet {
            showErrorDialog = true
        }
    }
    
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
            dialogErrorMessage = "기상송 검색을 실패했어요"
        }
    }
    
    @MainActor
    func postWakeupSong() async {
        do {
            if !videoUrl.isEmpty {
                try await wakeupSongRepository.postWakeupSong(
                    .init(videoUrl: videoUrl)
                )
            }
            if !(title + artist).isEmpty {
                try await wakeupSongRepository.postWakeupSongByKeyword(
                    .init(artist: artist, title: title)
                )
            }
        } catch let error {
            print(error)
            dialogErrorMessage = "기상송 신청을 실패했어요"
        }
    }
    
    @MainActor
    func clearData() {
        videoUrl = ""
        title = ""
        artist = ""
    }
}
