//
//  LoginView.swift
//  DodamDodam
//
//  Created by 이민규 on 3/14/24.
//

import SwiftUI

struct LoginView: View {
    
    @State var testIdText: String = ""
    @State var testPwText: String = ""
    
    @InjectObject var viewModel: LoginViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("아이디와 비밀번호를\n입력해주세요")
                .font(.heading3)
            DodamTextField.default(
                title: "아이디",
                text: $testIdText
            )
            .makeFirstResponder()
            DodamTextField.secured(
                title: "비밀번호",
                text: $testPwText
            )
            HStack(spacing: 0) {
                Text("비밀번호를 잊으셨나요? ")
                    .font(.body3)
                    .foregroundStyle(Color(.tertiary))
                Button {
                    // action
                } label: {
                    Text("비밀번호 재설정")
                        .font(.body3)
                        .underline()
                        .foregroundStyle(Color(.onBackground))
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.top, 16)
            
            DodamButton.fullWidth(
                title: "로그인"
            ) {
                // action
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
