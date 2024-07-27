//
//  AppMain.swift
//  DodamDodam
//
//  Created by Mercen on 3/12/24.
//

import SwiftUI
import FlowKit
import SignKit
import DDS
import DIContainer
import Feature
import Shared

@main
struct AppMain: App {
    
    init() {
        Pretendard.register()
        DependencyProvider.shared.register()
    }
    
    var body: some Scene {
        WindowGroup {
            FlowPresenter(rootView: MainView())
                .ignoresSafeArea()
        }
    }
}
