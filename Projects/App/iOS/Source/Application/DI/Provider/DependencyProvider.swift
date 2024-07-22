//
//  DependencyProvider.swift
//  DodamDodam
//
//  Created by Mercen on 3/13/24.
//

import Swinject

class DependencyProvider {
    
    static let shared = DependencyProvider()
    
    let container = Container()
    let assembler: Assembler
    
    init() {
        Container.loggingFunction = nil
        assembler = Assembler(
            [
                FlowAssembly(),
                DataSourceAssembly(),
                RemoteAssembly(),
                RepositoryAssembly()
            ],
            container: container
        )
    }
}
