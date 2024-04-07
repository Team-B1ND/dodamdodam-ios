//
//  MainView.swift
//  DodamDodam
//
//  Created by Mercen on 3/12/24.
//

import SwiftUI
import DDS

struct MainView: View {
    
    @State var selection: Int = 0
    
    var body: some View {
        DodamTabView(selection: $selection) {
            HomeView(selection: $selection)
                .page(.icon(.home))
            MealView()
                .page(.icon(.forkAndKnife))
            OutView()
                .page(.icon(.doorOpen))
            NightStudyView()
                .page(.icon(.moonPlus))
            AllView()
                .page(.icon(.menu))
        }
    }
}

#Preview {
    MainView()
}
