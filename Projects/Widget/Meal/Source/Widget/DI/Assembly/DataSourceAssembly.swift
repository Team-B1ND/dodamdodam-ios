//
//  DataSourceAssembly.swift
//  DodamDodam-MealWidget
//
//  Created by Mercen on 4/5/24.
//

import Swinject

struct DataSourceAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(MealDataSource.self) {
            .init(
                remote: $0.resolve(MealRemote.self)!,
                database: $0.resolve(MealDatabase.self)!
            )
        }.inObjectScope(.container)
    }
}
