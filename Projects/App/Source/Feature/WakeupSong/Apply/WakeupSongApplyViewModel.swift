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
    
    // MARK: - Repository
    @Inject var wakeupSongRepository: any WakeupSongRepository
    
    // MARK: - Method
    @MainActor
    func onAppear() async {
        
        await fetchWakeupSongChart()
    }
    
    @MainActor
    func fetchWakeupSongChart() async {
        
        do {
            wakeupSongChartData = try await wakeupSongRepository.fetchWakeupSongChart()
        } catch let error {
            print(error)
        }
    }
}
