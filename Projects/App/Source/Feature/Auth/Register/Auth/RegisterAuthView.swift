//
//  RegisterAuthView.swift
//  DodamDodam
//
//  Created by 이민규 on 3/15/24.
//

import SwiftUI

struct RegisterAuthView: View {
    
    @State var step: Int = 0
    
    @State var testIdText: String = ""
    @State var testPwText: String = ""
    @State var testCheckPwText: String = ""
    
    @InjectObject var viewModel: RegisterInfoViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text({ () -> String in
                switch step {
                case 0: return "아이디를\n입력해주세요"
                case 1: return "비밀번호를\n입력해주세요"
                default: return "비밀번호를\n확인해주세요"
                }
            }())
            .font(.heading3)
            
            if step >= 0 {
                DodamTextField.default(
                    title: "아이디",
                    text: $testIdText
                )
                .makeFirstResponder()
            }
            if step >= 1 {
                DodamTextField.default(
                    title: "비밀번호",
                    text: $testPwText
                )
                .makeFirstResponder()
            }
            if step >= 2 {
                DodamTextField.default(
                    title: "비밀번호 확인",
                    text: $testCheckPwText
                )
                .makeFirstResponder()
            }
            Spacer()
            
            if step >= 4 {
                DodamButton.fullWidth(
                    title: "가입하기"
                ) {
                    // action
                }
                .padding(.bottom, 24)
            }
        }
        .padding(.horizontal, 16)
        .ignoresSafeArea(.keyboard)
    }
}

#Preview {
    RegisterAuthView()
}
