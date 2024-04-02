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
        DodamScrollView.medium(title: "내 상벌점") {
            VStack(spacing: 0) {
                SegmentedView(
                    labels: ["기숙사", "학교"],
                    selection: $viewModel.selection
                )
                VStack(spacing: 24) {
                    
                }
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
