//
//  AllView.swift
//  DodamDodam
//
//  Created by 이민규 on 3/29/24.
//

import SwiftUI
import DDS

struct AllView: View {
    
    @InjectObject var viewModel: AllViewModel
    @Flow var flow
    
    var body: some View {
        DodamScrollView {
            
        } content: {
            
        }
    }
}

#Preview {
    AllView()
}
