//
//  PointViewModel.swift
//  DodamDodam
//
//  Created by 이민규 on 4/3/24.
//

import Combine

class PointViewModel: ObservableObject {
    
    // MARK: - State
    @Published var domitoryPointData: [PointResponse]?
    @Published var schoolPointData: [PointResponse]?
    @Published var domitoryPointScoreData: [PointScoreResponse]?
    @Published var schoolPointScoreData: [PointScoreResponse]?
    
    @Published var selection: Int = 0
    
    // MARK: - Repository
    @Inject var pointRepository: any PointRepository
    
    // MARK: - Method
    @MainActor
    func onAppear() async {
        
        await fetchPointScore()
    }
    
    @MainActor
    func fetchPoint() async {
        
        do {
            domitoryPointData = try await pointRepository.fetchPoint(
                .init(type: .dormitory)
            )
            schoolPointData = try await pointRepository.fetchPoint(
                .init(type: .school)
            )
        } catch let error {
            print(error)
        }
    }
    
    @MainActor
    func fetchPointScore() async {
        
        do {
            domitoryPointScoreData = try await pointRepository.fetchPointScore(
                .init(type: .dormitory)
            )
            schoolPointScoreData = try await pointRepository.fetchPointScore(
                .init(type: .school)
            )
        } catch let error {
            print(error)
        }
    }
}
