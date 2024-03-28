//
//  FlowAssembly.swift
//  DodamDodam
//
//  Created by Mercen on 3/13/24.
//

import Swinject
import FlowKit

struct FlowAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(FlowProvider.self) { _ in
                .init(rootView: HomeView()) {
                    NavigationController(rootViewController: $0)
                }
        }.inObjectScope(.container)
    }
}
