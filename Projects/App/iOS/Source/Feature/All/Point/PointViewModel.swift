//
//  PointViewModel.swift
//  DodamDodam
//
//  Created by 이민규 on 4/3/24.
//

import Combine
import Domain
import DIContainer

class PointViewModel: ObservableObject {
    
    // MARK: - State
    @Published var domitoryPointData: [PointResponse]?
    @Published var schoolPointData: [PointResponse]?
    @Published var domitoryPointScoreData: PointScoreResponse?
    @Published var schoolPointScoreData: PointScoreResponse?
    
    var bocus: Int? {
        guard let domitoryBonus = domitoryPointScoreData?.bonus,
              let schoolBonus = schoolPointScoreData?.bonus else {
            return nil
        }
        return selection == 0 ? domitoryBonus : schoolBonus
    }
    
    var minus: Int? {
        guard let domitoryMinus = domitoryPointScoreData?.minus,
              let schoolMinus = schoolPointScoreData?.minus else {
            return nil
        }
        return selection == 0 ? domitoryMinus : schoolMinus
    }
    
    var pointData: [PointResponse]? {
        guard let domitoryPointData,
              let schoolPointData else {
            return nil
        }
        return selection == 0 ? domitoryPointData : schoolPointData
    }
    
    @Published var selection: Int = 0
    
    // MARK: - Repository
    @Inject var pointRepository: any PointRepository
    
    // MARK: - Method
    @MainActor
    func onAppear() async {
        async let fetchPointScore: () = fetchPointScore()
        async let fetchPoint: () = fetchPoint()
        _ = await [fetchPointScore, fetchPoint]
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
