//
//  NightStudyViewModel.swift
//  DodamDodam
//
//  Created by 이민규 on 3/28/24.
//

import Combine

class NightStudyViewModel: ObservableObject {
    
    // MARK: - State
    @Published var nightStudyData: [NightStudyResponse]?
    @Published var isShowingDeleteAlert: Bool = false
    
    // MARK: - Repository
    @Inject var nightStudyRepository: any NightStudyRepository

    // MARK: - Method
    @MainActor
    func onAppear() async {
        
        await fetchNightStudy()
    }
    
    @MainActor
    func onRefresh() async {

        await fetchNightStudy()
    }
    
    @MainActor
    func fetchNightStudy() async {
        
        do {
            nightStudyData = try await nightStudyRepository.fetchNightStudy()
            print("test: ", nightStudyData)
        } catch let error {
            print(error)
        }
    }
    
    @MainActor
    func deleteOutGoing(id: Int) async {
        
        do {
            try await nightStudyRepository.deleteNightStudy(id: id)
        } catch let error {
            print(error)
        }
    }
}
