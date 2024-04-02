//
//  PointView.swift
//  DodamDodam
//
//  Created by 이민규 on 4/3/24.
//

import SwiftUI
import DDS

struct PointView: View {
    
    @InjectObject var viewModel: PointViewModel
    @Flow var flow
    
    var body: some View {
        DodamScrollView.default(title: "내 상벌점") {
            VStack(spacing: 24) {
                
            }
            .padding([.top, .horizontal], 16)
        }
        .bottomMask()
        .task {
            await viewModel.onAppear()
        }
    }
}

#Preview {
    FlowPreview {
        PointView()
    }
}
