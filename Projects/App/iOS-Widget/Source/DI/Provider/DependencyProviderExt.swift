//
//  DependencyProvider.swift
//  DodamDodam
//
//  Created by Mercen on 3/13/24.
//

import Swinject
import DIContainer

public extension DependencyProvider {
    
    func register() {
        Container.loggingFunction = nil
        _ = Assembler(
            [
                DataSourceAssembly(),
                RemoteAssembly(),
                RepositoryAssembly(),
                LocalAssembly()
            ],
            container: self.container
        )
    }
}
