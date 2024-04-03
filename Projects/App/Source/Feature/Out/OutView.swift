//
//  OutView.swift
//  DodamDodam
//
//  Created by 이민규 on 3/21/24.
//

import SwiftUI
import DDS

struct OutView: View {
    
    @InjectObject var viewModel: OutViewModel
    @Flow var flow
    
    @Namespace private var animation
    
    var body: some View {
        DodamScrollView.default(title: "외출/외박") {
            VStack(spacing: 12) {
                if viewModel.selection == 0 {
                    if let data = viewModel.outGoingData,
                       !data.isEmpty {
                        ForEach(data, id: \.self) { data in
                            OutGoingCell(
                                data: data
                            )
                        }
                    } else {
                        DodamEmptyView(
                            .outGoing
                        ) {
                            flow.push(OutApplyView())
                        }
                    }
                }
                if viewModel.selection == 1 {
                    if let data = viewModel.outSleepingData,
                       !data.isEmpty {
                        ForEach(data, id: \.self) { data in
                            OutSleepingCell(
                                data: data
                            )
                        }
                    } else {
                        DodamEmptyView(
                            .outSleeping
                        ) {
                            flow.push(OutApplyView())
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 150)
        }
        .subView {
            SegmentedView(
                labels: ["외출", "외박"],
                selection: $viewModel.selection
            )
        }
        .button(icon: .plus) {
            flow.push(OutApplyView())
        }
        .background(Dodam.color(.surface))
        .task {
            await viewModel.onAppear()
        }
        .refreshable {
            await viewModel.onRefresh()
        }
    }
}

#Preview {
    OutView()
}
