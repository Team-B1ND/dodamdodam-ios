//
//  ViewModelAssembly.swift
//  DodamDodam
//
//  Created by Mercen on 3/13/24.
//

import Swinject

class ViewModelAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(MainViewModel.self) { _ in
            MainViewModel()
        }
    }
}
