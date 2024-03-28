//
//  ViewModelAssembly.swift
//  DodamDodam
//
//  Created by Mercen on 3/13/24.
//

import Swinject

class ViewModelAssembly: Assembly {
    
    func assemble(container: Container) {
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
        container.register(MainViewModel.self) { _ in
            MainViewModel()
        }
        container.register(HomeViewModel.self) { _ in
            HomeViewModel()
        }
        container.register(MealViewModel.self) { _ in
            MealViewModel()
        }
        container.register(OutViewModel.self) { _ in
            OutViewModel()
        }
        container.register(OutApplyViewModel.self) { _ in
            OutApplyViewModel()
        }
        container.register(NightStudyViewModel.self) { _ in
            NightStudyViewModel()
        }
        container.register(NightStudyApplyViewModel.self) { _ in
            NightStudyApplyViewModel()
        }
    }
}
