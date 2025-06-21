//
//  AppMainWatch.swift
//  DodamDodam
//
//  Created by 김은찬 on 6/11/25.
//

import Foundation
import SwiftUI
import DDS

@main
struct AppMainWatch: App {
    
    init() {
        Pretendard.register()
    }
    
    var body: some Scene {
        WindowGroup {
            DodamWatchView()
        }
    }
}
