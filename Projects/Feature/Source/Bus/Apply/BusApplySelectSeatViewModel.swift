//
//  BusApplySelectSeatViewModel.swift
//  Feature
//
//  Created by hhhello0507 on 3/10/25.
//

import Foundation
import Domain
import DIContainer

final class BusApplySelectSeatViewModel: ObservableObject {
    
    // MARK: - State
    @Published var seatNumber: Int?
    
    private let busId: Int
    
    // MARK: - Repository
    @Inject var busRepository: any BusRepository
    
    // MARK: - Method
    init(busId: Int) {
        self.busId = busId
    }
    
    @MainActor
    func patchStatus(completion: @escaping () -> Void) async {
        guard let seatNumber else { return }
        
        do {
            try await busRepository.patchBusStatus(id: busId, seatNumber: seatNumber)
            completion()
        } catch {
            print(error)
        }
    }
}
