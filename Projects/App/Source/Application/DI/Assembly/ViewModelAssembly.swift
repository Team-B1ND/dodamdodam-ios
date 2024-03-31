//
//  ViewModelAssembly.swift
//  DodamDodam
//
//  Created by Mercen on 3/13/24.
//

import Swinject

struct ViewModelAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(OnboardingViewModel.self) { _ in
                .init()
        }.inObjectScope(.container)
        
        container.register(LoginViewModel.self) { _ in
                .init()
        }.inObjectScope(.container)
        
        container.register(RegisterViewModel.self) { _ in
                .init()
        }.inObjectScope(.container)
        
        container.register(HomeViewModel.self) { _ in
                .init()
        }.inObjectScope(.container)
        
        container.register(MealViewModel.self) { _ in
                .init()
        }.inObjectScope(.container)
        
        container.register(OutViewModel.self) { _ in
                .init()
        }.inObjectScope(.container)
        
        container.register(OutApplyViewModel.self) { _ in
                .init()
        }.inObjectScope(.container)
        
        container.register(NightStudyViewModel.self) { _ in
                .init()
        }.inObjectScope(.container)
        
        container.register(NightStudyApplyViewModel.self) { _ in
                .init()
        }.inObjectScope(.container)
        
        container.register(AllViewModel.self) { _ in
                .init()
        }.inObjectScope(.container)
    }
}
