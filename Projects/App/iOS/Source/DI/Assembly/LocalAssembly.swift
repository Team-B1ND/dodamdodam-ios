//
//  DataSourceAssembly.swift
//  DodamDodam
//
//  Created by Mercen on 3/28/24.
//

import Swinject
import Local

struct LocalAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(MealCache.self) { _ in
                .init()
        }.inObjectScope(.container)
    }
}
