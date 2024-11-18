//
//  RegisterInfoView.swift
//  DodamDodam
//
//  Created by 이민규 on 3/15/24.
//

import SwiftUI
import DDS
import Shared
import FlowKit

struct RegisterInfoView: View {
    
    @StateObject var viewModel = RegisterViewModel()
    @Flow var flow
    
    var body: some View {
        DodamScrollView.medium(
            title: { () -> String in
                switch viewModel.infoStep {
                case 0: "이름을\n입력해주세요"
                case 1: "학생정보를\n입력해주세요"
                case 2: "이메일을\n입력해주세요"
                default: "전화번호를\n입력해주세요"
                }
            }()
        ) {
            VStack(alignment: .leading, spacing: 24) {
                if viewModel.infoStep >= 3 {
                    DodamTextField.default(
                        title: "전화번호",
                        text: $viewModel.phoneText
                    )
                    .makeFirstResponder()
                    .keyboardType(.numberPad)
                    .onSubmit {
                        viewModel.infoStep = 4
                    }
                    .transition(.slide)
                    .animation(
                        Animation.easeIn(duration: 0.2),
                        value: viewModel.infoStep
                    )
                }
                
                if viewModel.infoStep >= 2 {
                    DodamTextField.default(
                        title: "이메일",
                        text: $viewModel.emailText
                    )
                    .makeFirstResponder()
                    .keyboardType(.emailAddress)
                    .onSubmit {
                        viewModel.infoStep = 3
                    }
                    .transition(.slide)
                    .animation(
                        Animation.easeIn(duration: 0.2),
                        value: viewModel.infoStep
                    )
                }
                
                if viewModel.infoStep >= 1 {
                    DodamTextField.default(
                        title: "학생정보",
                        text: $viewModel.infoText
                    )
                    .makeFirstResponder()
                    .keyboardType(.numberPad)
                    .onSubmit {
                        viewModel.infoStep = 2
                    }
                    .transition(.slide)
                    .animation(
                        Animation.easeIn(duration: 0.2),
                        value: viewModel.infoStep
                    )
                }
                
                if viewModel.infoStep >= 0 {
                    DodamTextField.default(
                        title: "이름",
                        text: $viewModel.nameText
                    )
                    .makeFirstResponder()
                    .onSubmit {
                        viewModel.infoStep = 1
                    }
                    .transition(.slide)
                    .animation(
                        Animation.easeIn(duration: 0.2),
                        value: viewModel.infoStep
                    )
                }
                Spacer()
            }
        }
        .safeAreaInset(edge: .bottom) {
            let info = viewModel.infoStep == 1 && viewModel.infoText.count >= 9
            let call = viewModel.infoStep == 3 && viewModel.phoneText.count == 13
            if info || call {
                DodamButton.fullWidth(
                    title: "다음"
                ) {
                    if info {
                        viewModel.infoStep = 2
                    } else {
                        flow.push(
                            RegisterAuthView().environmentObject(viewModel)
                        )
                    }
                }
                .padding(.bottom, 24)
            }
        }
        .onChange(of: viewModel.infoText) {
            if let infoText = FormatUtil.formatMemberInfo($0) {
                viewModel.infoText = infoText
            }
        }
        .onChange(of: viewModel.phoneText) {
            if let phoneText = FormatUtil.formatPhone($0) {
                viewModel.phoneText = phoneText
            }
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    FlowPreview {
        RegisterInfoView()
    }
}
