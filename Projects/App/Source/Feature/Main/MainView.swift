//
//  MainView.swift
//  DodamDodam
//
//  Created by Mercen on 3/12/24.
//

import SwiftUI

struct MainView: View {
    
    @InjectObject var viewModel: MainViewModel
    
    var body: some View {
        Text("Hello, world!")
    }
}

#Preview {
    MainView()
}
