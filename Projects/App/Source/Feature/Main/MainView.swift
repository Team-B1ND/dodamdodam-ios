//
//  MainView.swift
//  DodamDodam
//
//  Created by Mercen on 3/12/24.
//

import SwiftUI
import DDS

struct MainView: View {
    
    @InjectObject var viewModel: MainViewModel
    
    var body: some View {
        DodamTabView(selection: $viewModel.selection) {
            HomeView()
                .page(.icon(.home))
            MealView()
                .page(.icon(.forkAndKnife))
            OutView()
                .page(.icon(.doorOpen))
            Text("NightStudy")
                .page(.icon(.moonPlus))
            Text("Menu")
                .page(.icon(.menu))
        }
    }
}

#Preview {
    MainView()
}
