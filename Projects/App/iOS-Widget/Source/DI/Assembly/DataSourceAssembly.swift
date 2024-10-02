//
//  DataSourceAssembly.swift
//  DodamDodam
//
//  Created by Mercen on 3/28/24.
//

import Swinject
import DataSource
import Network
import Repository
import Local

struct DataSourceAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(MealDataSource.self) {
            .init(remote: $0.resolve(MealRemote.self)!)
        }.inObjectScope(.container)
        
        container.register(LocalMealDataSource.self) {
            .init(mealCache: $0.resolve(MealCache.self)!)
        }.inObjectScope(.container)
    }
}
