//
//  OutViewModel.swift
//  DodamDodam
//
//  Created by 이민규 on 3/21/24.
//

import Combine

class OutViewModel: ObservableObject {
    
    @Published var selection: Int = 0
    @Published var outGoingData: [Out]?
    @Published var outSleepingData: [Out]?
}
