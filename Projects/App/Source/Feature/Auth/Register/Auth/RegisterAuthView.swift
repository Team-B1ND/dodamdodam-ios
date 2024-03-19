//
//  RegisterAuthView.swift
//  DodamDodam
//
//  Created by 이민규 on 3/15/24.
//

import SwiftUI
import DDS

struct RegisterAuthView: View {
    
    // UI test state
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
            .font(.headline(.small))
            
            if step >= 2 {
                DodamTextField.default(
                    title: "비밀번호 확인",
                    text: $testCheckPwText
                )
                .makeFirstResponder()
                .onSubmit {
                    step = 3
                }
                .transition(.slide)
                .animation(
                    Animation.easeIn(duration: 0.2),
                    value: step
                )
            }
            
            if step >= 1 {
                DodamTextField.default(
                    title: "비밀번호",
                    text: $testPwText
                )
                .makeFirstResponder()
                .onSubmit {
                    step = 2
                }
                .transition(.slide)
                .animation(
                    Animation.easeIn(duration: 0.2),
                    value: step
                )
            }
            
            if step >= 0 {
                DodamTextField.default(
                    title: "아이디",
                    text: $testIdText
                )
                .makeFirstResponder()
                .onSubmit {
                    step = 1
                }
                .transition(.slide)
                .animation(
                    Animation.easeIn(duration: 0.2),
                    value: step
                )
            }
            Spacer()
            
            DodamButton.fullWidth(
                title: "가입하기"
            ) {
                // action
            }
            .padding(.bottom, 24)
        }
        .padding(.horizontal, 16)
        .ignoresSafeArea(.keyboard)
    }
}

#Preview {
    RegisterAuthView()
}
