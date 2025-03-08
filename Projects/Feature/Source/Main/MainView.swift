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
        DodamTabView(selection: $selection) {
            HomeView(selection: $selection)
                .page(.icon(.home))
            NoticeView()
                .page(.icon(.bell))
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
