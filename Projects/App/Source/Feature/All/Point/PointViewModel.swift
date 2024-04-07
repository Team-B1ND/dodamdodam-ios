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
    @Published var domitoryPointScoreData: PointScoreResponse? {
        didSet {
            bonus[0] = domitoryPointScoreData?.bonus ?? 0
            minus[0] = domitoryPointScoreData?.minus ?? 0
        }
    }
    @Published var schoolPointScoreData: PointScoreResponse? {
        didSet {
            bonus[1] = schoolPointScoreData?.bonus ?? 0
            minus[1] = schoolPointScoreData?.minus ?? 0
        }
    }
    
    @Published var bonus: [Int] = [0, 0]
    @Published var minus: [Int] = [0, 0]
    @Published var selection: Int = 0
    
    // MARK: - Repository
    @Inject var pointRepository: any PointRepository
    
    // MARK: - Method
    @MainActor
    func onAppear() async {
        await fetchPointScore()
        await fetchPoint()
    }
    
    @MainActor
    func onRefresh() async {
        clearData()
        await onAppear()
    }
    
    @MainActor
    func clearData() {
        domitoryPointData = nil
        schoolPointData = nil
        domitoryPointScoreData = nil
        schoolPointScoreData = nil
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
