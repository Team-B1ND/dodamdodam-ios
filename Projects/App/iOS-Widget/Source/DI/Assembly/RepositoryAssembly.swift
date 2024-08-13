//
//  RepositoryAssembly.swift
//  DodamDodam
//
//  Created by Mercen on 3/28/24.
//

import Swinject
import Repository
import DataSource
import Domain

struct RepositoryAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register((any MealRepository).self) {
            MealRepositoryImpl(dataSource: $0.resolve(MealDataSource.self)!)
        }.inObjectScope(.container)
    }
}
