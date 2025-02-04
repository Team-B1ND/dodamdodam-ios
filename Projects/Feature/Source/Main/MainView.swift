//
//  MainView.swift
//  DodamDodam
//
//  Created by Mercen on 3/12/24.
//

import SwiftUI
import DDS
import FlowKit

public struct MainView: View {
    
    @State var selection: Int = 0
    
    public init() {}
    
    public var body: some View {
        return DivisionView()
        DodamTabView(selection: $selection) {
            HomeView(selection: $selection)
                .page(.icon(.home))
            MealView()
                .page(.icon(.forkAndKnife))
            OutView()
                .page(.icon(.doorOpen))
            NightStudyView()
                .page(.icon(.moonPlus))
            AllView(selection: $selection)
                .page(.icon(.menu))
        }
    }
}

#Preview {
    MainView()
}
