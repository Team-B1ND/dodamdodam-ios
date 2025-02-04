//
//  RegisterAuthView.swift
//  DodamDodam
//
//  Created by 이민규 on 3/15/24.
//

import SwiftUI
import DDS
import FlowKit

struct RegisterAuthView: View {
    
    @EnvironmentObject var viewModel: RegisterViewModel
    @Flow var flow
    
    var body: some View {
        DodamTopAppBar.medium(
            title: { () -> String in
                switch viewModel.authStep {
                case 0: return "아이디를\n입력해주세요"
                case 1: return "비밀번호를\n입력해주세요"
                default: return "비밀번호를\n확인해주세요"
                }
            }()
        )
        VStack(alignment: .leading, spacing: 24) {
            if viewModel.authStep >= 2 {
                DodamTextField.default(
                    title: "비밀번호 확인",
                    text: $viewModel.checkPwText
                )
                .makeFirstResponder()
                .onSubmit {
                    viewModel.authStep = 3
                }
                .transition(.slide)
                .animation(
                    Animation.easeIn(duration: 0.2),
                    value: viewModel.authStep
                )
            }
            
            if viewModel.authStep >= 1 {
                DodamTextField.default(
                    title: "비밀번호",
                    text: $viewModel.pwText
                )
                .makeFirstResponder()
                .onSubmit {
                    viewModel.authStep = 2
                }
                .transition(.slide)
                .animation(
                    Animation.easeIn(duration: 0.2),
                    value: viewModel.authStep
                )
            }
            
            if viewModel.authStep >= 0 {
                VStack(alignment: .leading, spacing: 4) {
                    DodamTextField.default(
                        title: "아이디",
                        text: $viewModel.idText
                    )
                    .makeFirstResponder()
                    .onSubmit {
                        viewModel.authStep = 1
                    }
                    .keyboardType(.asciiCapable)
                    Text("아이디는 영문과 숫자로 5 ~ 20글자 이내여야 해요.")
                        .label(.medium)
                        .foreground(DodamColor.Label.alternative)
                }
                .transition(.slide)
                .animation(
                    Animation.easeIn(duration: 0.2),
                    value: viewModel.authStep
                )
            }
            Spacer()
            
            if viewModel.authStep >= 3 {
                DodamButton.fullWidth(
                    title: "가입하기"
                ) {
                    await viewModel.postJoin {
                        flow.replace(
                            [MainView()
                                .toast(timeout: 3) {
                                    Text("회원가입에 성공했어요!")
                                }
                            ]
                        )
                    }
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
