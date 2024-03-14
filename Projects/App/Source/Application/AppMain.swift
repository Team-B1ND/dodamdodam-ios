//
//  AppMain.swift
//  DodamDodam
//
//  Created by Mercen on 3/12/24.
//

import SwiftUI
import FlowKit

@main
struct AppMain: App {
    
    @Inject private var flow: FlowProvider
    
    var body: some Scene {
        WindowGroup {
            flow.present()
                .ignoresSafeArea()
        }
    }
}
