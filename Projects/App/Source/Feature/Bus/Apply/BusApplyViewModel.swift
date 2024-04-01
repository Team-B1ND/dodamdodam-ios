//
//  BusApplyViewModel.swift
//  DodamDodam
//
//  Created by dgsw8th71 on 4/1/24.
//

import Foundation

class BusApplyViewModel: ObservableObject {
    
    @Inject var busRepository: any BusRepository
    
    @Published var bus: [BusResponse] = []
    
    func fetchBuses() async {
        do {
            bus = try await busRepository.fetchAllBus()
        } catch {
            debugPrint(error)
        }
    }
    
    
    
//    func 
}
