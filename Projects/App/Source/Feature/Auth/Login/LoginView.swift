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
//            HStack(spacing: 0) {
//                Text("비밀번호를 잊으셨나요? ")
//                    .font(.body(.small))
//                    .dodamColor(.tertiary)
//                Button {
//                    // action
//                } label: {
//                    Text("비밀번호 재설정")
//                        .font(.body(.small))
//                        .underline()
//                        .dodamColor(.onBackground)
//                }
//            }
//            .frame(maxWidth: .infinity, alignment: .center)
//            .padding(.top, 16)
            
            DodamButton.fullWidth(
                title: "로그인"
            ) {
                await viewModel.postLogin {
                    flow.replace([
                        MainView()
                    ])
                }
            }
            .padding(.top, 8)
            Spacer()
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    LoginView()
}
