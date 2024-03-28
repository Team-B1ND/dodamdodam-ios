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
        
        container.register(RegisterInfoViewModel.self) { _ in
                .init()
        }.inObjectScope(.container)
        
        container.register(RegisterAuthViewModel.self) { _ in
                .init()
        }.inObjectScope(.container)
        
        container.register(MainViewModel.self) { _ in
                .init()
        }.inObjectScope(.container)
        
        container.register(HomeViewModel.self) { _ in
                .init()
        }.inObjectScope(.container)
        
        container.register(MealViewModel.self) { _ in
                .init()
        }.inObjectScope(.container)
    }
}
