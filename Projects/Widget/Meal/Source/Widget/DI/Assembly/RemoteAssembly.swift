//
//  RemoteAssembly.swift
//  DodamDodam-MealWidget
//
//  Created by Mercen on 4/5/24.
//

import Swinject

struct RemoteAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(MealRemote.self) { _ in
                .init()
        }.inObjectScope(.container)
    }
}
