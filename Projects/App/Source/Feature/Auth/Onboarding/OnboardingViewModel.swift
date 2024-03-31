//
//  OnboardingViewModel.swift
//  DodamDodam
//
//  Created by 이민규 on 3/13/24.
//

import Combine

class OnboardingViewModel: ObservableObject {
    
    // MARK: - State
    @Published var isChecked1: Bool = false
    @Published var isChecked2: Bool = false
    @Published var isModalPresented: Bool = false
    
    // MARK: - Repository
    
    // MARK: - Method
    func onTapRegisterButton() {
        
        isModalPresented.toggle()
    }
    
    func isChecked() -> Bool {
        
        isChecked1 && isChecked2
    }
}
