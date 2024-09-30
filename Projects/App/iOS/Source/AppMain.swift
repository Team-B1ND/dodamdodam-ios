//
//  AppMain.swift
//  DodamDodam
//
//  Created by Mercen on 3/12/24.
//

import SwiftUI
import DIContainer
import Feature
import Shared
import DDS
import FlowKit
import Realm

@main
struct AppMain: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init() {
        Pretendard.register()
        DependencyProvider.shared.register()
    }
    
    @StateObject private var dialogProvider = DialogProvider()
    @StateObject private var datePickerProvider = DatePickerProvider()
    @StateObject private var timePickerProvider = TimePickerProvider()
    @StateObject private var flow = FlowProvider(rootView: MainView())
    
    var body: some Scene {
        WindowGroup {
            DodamModalProvider(
                dialogProvider: dialogProvider,
                datePickerProvider: datePickerProvider,
                timePickerProvider: timePickerProvider
            ) {
                FlowPresenter(flow: flow)
            }
            .ignoresSafeArea()
            .onAppear {
#if DEBUG
                print("Realm DB location: \(RLMRealmConfiguration.default().fileURL!)")
#endif
            }
        }
    }
}
