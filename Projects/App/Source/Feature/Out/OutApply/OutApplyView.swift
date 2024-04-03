//
//  OutApplyView.swift
//  DodamDodam
//
//  Created by 이민규 on 3/21/24.
//

import SwiftUI
import DDS

struct OutApplyView: View {
    
    @InjectObject var viewModel: OutApplyViewModel
    
    var body: some View {
        DodamNavigationBar.medium(title: "외출 외박 신청하기")
        VStack(alignment: .leading, spacing: 24) {
            SegmentedView(
                labels: ["외출", "외박"],
                selection: $viewModel.selection
            )
            .padding(.top, 6)
            DodamTextField.default(
                title: "\(viewModel.selection == 0 ? "외출" : "외박") 사유",
                text: $viewModel.testText
            )
            /// 컴포넌트 넣기
            Spacer()
            DodamButton.fullWidth(
                title: "확인"
            ) {
                // action
            }
            .padding(.bottom, 8)
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    OutApplyView()
}
