//
//  AppMain.swift
//  DodamDodam
//
//  Created by 이민규 on 2023/05/24.
//  Copyright © 2023 B1ND. All rights reserved.
//

import SwiftUI
import Dependencies
import LinkNavigator

@main
struct AppMain {
    
    @Dependency(\.sideEffect) var sideEffect
}

extension AppMain {
    
    var navigator: LinkNavigator {
        sideEffect.linkNavigator as! LinkNavigator
    }
}

extension AppMain: App {
    
    var body: some Scene {
        
        WindowGroup {
            navigator
                .launch(paths: ["home"], items: [:], prefersLargeTitles: false)
                .ignoresSafeArea()
        }
    }
}
