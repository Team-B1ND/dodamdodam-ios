//
//  LocalAssembly.swift
//  DodamDodam
//
//  Created by hhhello0507 on 9/17/24.
//

import Foundation
import Swinject
import Local
import Domain

struct LocalAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(MealCache.self) { _ in
                .init()
        }.inObjectScope(.container)
    }
}
