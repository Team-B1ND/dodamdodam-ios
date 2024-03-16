//
//  ViewModelAssembly.swift
//  DodamDodam
//
//  Created by Mercen on 3/13/24.
//

import Swinject

class ViewModelAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(MainViewModel.self) { _ in
            MainViewModel()
        }
        container.register(OnboardingViewModel.self) { _ in
            OnboardingViewModel()
        }
        container.register(LoginViewModel.self) { _ in
            LoginViewModel()
        }
        container.register(RegisterInfoViewModel.self) { _ in
            RegisterInfoViewModel()
        }
        container.register(RegisterAuthViewModel.self) { _ in
            RegisterAuthViewModel()
        }
    }
}
