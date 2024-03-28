//
//  NightStudyApplyView.swift
//  DodamDodam
//
//  Created by 이민규 on 3/28/24.
//

import SwiftUI
import DDS

struct NightStudyApplyView: View {
    
    @InjectObject var viewModel: NightStudyApplyViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("심야 자습 신청하기")
                .font(.headline(.small))
            
            DodamTextField.default(
                title: "심야 자습 사유",
                text: $viewModel.testText1
            )
            .padding(.top, 16)
            /// 컴포넌트 넣기
            if viewModel.isUsePhone {
                DodamTextField.default(
                    title: "휴대폰 사용 사유",
                    text: $viewModel.testText2
                )
            }
            Spacer()
            DodamButton.fullWidth(
                title: "확인"
            ) {
                // action
            }
            .disabled(true)
            .padding(.bottom, 8)
        }
        .padding(.horizontal, 24)
        .navigationBarHidden(false)
    }
}

#Preview {
    NightStudyApplyView()
}
