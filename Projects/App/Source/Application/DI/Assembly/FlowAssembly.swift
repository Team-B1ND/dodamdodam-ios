//
//  FlowAssembly.swift
//  DodamDodam
//
//  Created by Mercen on 3/13/24.
//

import Swinject
import FlowKit

class FlowAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(FlowProvider.self) { _ in
            FlowProvider(rootView: OnboardingView()) {
                NavigationController(rootViewController: $0)
            }
        }
    }
}
