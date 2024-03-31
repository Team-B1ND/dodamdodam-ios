//
//  AppMain.swift
//  DodamDodam
//
//  Created by Mercen on 3/12/24.
//

import SwiftUI
import FlowKit
import SignKit

@propertyWrapper
public struct Flow: DynamicProperty {
    
    @EnvironmentObject private var object: FlowProvider
    
    public var wrappedValue: FlowProvider {
        object
    }
    
    public init() { }
}

@main
struct AppMain: App {
    
    var body: some Scene {
        WindowGroup {
            if Sign.isLoggedIn {
                FlowPresenter(rootView: MainView())
                    .ignoresSafeArea()
            } else {
                FlowPresenter(rootView: OnboardingView())
                    .ignoresSafeArea()
            }
        }
    }
}
