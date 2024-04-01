//
//  LoginView.swift
//  DodamDodam
//
//  Created by 이민규 on 3/14/24.
//

import SwiftUI
import DDS

struct LoginView: View {
    
    @InjectObject var viewModel: LoginViewModel
    @Flow var flow
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("아이디와 비밀번호를\n입력해주세요")
                .font(.headline(.small))
            DodamTextField.default(
                title: "아이디",
                text: $viewModel.idText
            )
            .makeFirstResponder()
            DodamTextField.secured(
                title: "비밀번호",
                text: $viewModel.pwText
            )
            DodamButton.fullWidth(
                title: "로그인"
            ) {
                await viewModel.postLogin {
                    flow.replace([
                        MainView()
                    ])
                }
            }
            .disabled(!viewModel.isValidIdAndPw())
            .padding(.top, 8)
            Spacer()
        }
        .padding(.horizontal, 16)
        .alert("실패", isPresented: $viewModel.isShowingAlert) {
            Button("확인", role: .none) { }
        } message: {
            Text("로그인이 실패했습니다.")
        }
    }
}

#Preview {
    FlowPreview {
        LoginView()
    }
}
