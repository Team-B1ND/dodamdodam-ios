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
                    if let datas = viewModel.outGoingDatas {
                        ForEach(datas, id: \.self) { data in
                            OutApplyCell(
                                data: data,
                                outType: .outGoing
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
                    if let datas = viewModel.outSleepingDatas {
                        ForEach(datas, id: \.self) { data in
                            OutApplyCell(
                                data: data,
                                outType: .outSleeping
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
        }
        .subView {
            OutSegmentedView(selection: $viewModel.selection)
        }
        .button(icon: .plus) {
            flow.push(OutApplyView())
        }
        .bottomMask()
    }
}

#Preview {
    OutView()
}
