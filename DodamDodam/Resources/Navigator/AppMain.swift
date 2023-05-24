//
//  AppMain.swift
//  DodamDodam
//
//  Created by 이민규 on 2023/05/24.
//  Copyright © 2023 B1ND. All rights reserved.
//

import SwiftUI
import Dependencies

@main
struct AppMain: App {
    
    var body: some Scene {
        
        WindowGroup {
            
            HomeView(store: .init(
                initialState: Home.State(),
                reducer: Home()))
        }
    }
}
