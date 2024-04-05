//
//  DependencyProvider.swift
//  DodamDodam-MealWidget
//
//  Created by Mercen on 4/5/24.
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
                DatabaseAssembly(),
                DataSourceAssembly(),
                RemoteAssembly(),
                RepositoryAssembly()
            ],
            container: container
        )
    }
}
