//
//  DatabaseAsssembly.swift
//  DodamDodam-MealWidget
//
//  Created by Mercen on 4/5/24.
//

import Swinject

struct DatabaseAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(MealDatabase.self) { _ in
            .init()
        }.inObjectScope(.container)
    }
}
