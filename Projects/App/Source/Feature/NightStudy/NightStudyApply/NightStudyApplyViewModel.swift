//
//  NightStudyApplyViewModel.swift
//  DodamDodam
//
//  Created by 이민규 on 3/28/24.
//

import Combine

class NightStudyApplyViewModel: ObservableObject {
    
    @Published var testText1: String = ""
    @Published var testText2: String = ""
    @Published var isUsePhone: Bool = false
}
