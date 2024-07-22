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

@propertyWrapper
public struct Flow: DynamicProperty {
    
    @EnvironmentObject private var object: FlowProvider
    
    public var wrappedValue: FlowProvider {
        object
    }
    
    public init() { }
}

public struct FlowPreview<C: View>: View {
    
    private let content: () -> C
    
    public init(@ViewBuilder content: @escaping () -> C) {
        self.content = content
    }
    
    public var body: some View {
        FlowPresenter(rootView: content())
            .ignoresSafeArea()
    }
}

@main
struct AppMain: App {
    
    init() {
        SUIT.register()
    }
    
    var body: some Scene {
        WindowGroup {
            FlowPresenter(rootView: MainView())
                .ignoresSafeArea()
        }
    }
}
