//
//  RepositoryAssembly.swift
//  DodamDodam-MealWidget
//
//  Created by Mercen on 4/5/24.
//

import Swinject

struct RepositoryAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register((any MealRepository).self) {
            MealRepositoryImpl(dataSource: $0.resolve(MealDataSource.self)!)
        }.inObjectScope(.container)
    }
}
