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
    
    @InjectObject var viewModel: RegisterViewModel
    @Flow var flow
    
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
                    text: $viewModel.checkPwText
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
                    text: $viewModel.pwText
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
                VStack(alignment: .leading, spacing: 4) {
                    DodamTextField.default(
                        title: "아이디",
                        text: $viewModel.idText
                    )
                    .makeFirstResponder()
                    .onSubmit {
                        step = 1
                    }
                    Text("아이디는 영문과 숫자로 5 ~ 20글자 이내여야 해요.")
                        .font(.label(.large))
                        .dodamColor(.onSurfaceVariant)
                }
                .transition(.slide)
                .animation(
                    Animation.easeIn(duration: 0.2),
                    value: step
                )
            }
            Spacer()
            
            if step >= 3 {
                DodamButton.fullWidth(
                    title: "가입하기"
                ) {
                    // action
                }
                .padding(.bottom, 24)
            }
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    RegisterAuthView()
}
