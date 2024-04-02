//
//  NightStudyView.swift
//  DodamDodam
//
//  Created by 이민규 on 3/28/24.
//

import SwiftUI
import DDS

struct NightStudyView: View {
    
    @InjectObject var viewModel: NightStudyViewModel
    @Flow var flow
    
    var body: some View {
        DodamScrollView.default(title: "심야 자습") {
            VStack(spacing: 20) {
                if let datas = viewModel.nightStudyData {
                    ForEach(datas, id: \.self) { data in
                       NightStudyApplyCell(data: data)
                    }
                } else {
                    DodamEmptyView(
                        .nightStudy
                    ) {
                        flow.push(NightStudyApplyView())
                    }
                }
            }
            .padding(.horizontal, 16)
        }
        .button(icon: .plus) {
            flow.push(NightStudyApplyView())
        }
        .bottomMask()
    }
}

#Preview {
    NightStudyView()
}
