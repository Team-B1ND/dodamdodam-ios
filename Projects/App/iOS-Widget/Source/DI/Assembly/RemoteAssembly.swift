//
//  RemoteAssembly.swift
//  DodamDodam
//
//  Created by Mercen on 3/28/24.
//

import Swinject
import Network

struct RemoteAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(MealRemote.self) { _ in
                .init()
        }.inObjectScope(.container)
    }
}
