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
    
    @EnvironmentObject var viewModel: RegisterViewModel
    @Flow var flow
    
    var body: some View {
        DodamScrollView.medium(
            title: { () -> String in
                switch viewModel.infoStep {
                case 0: "이름을\n입력해주세요"
                case 1: "학생정보를\n입력해주세요"
                case 2: "이메일을\n입력해주세요"
                case 3: "이메일을\n인증해주세요"
                case 4: "전화번호를\n입력해주세요"
                default: "전화번호를\n인증해주세요"
                }
            }()
        ) {
            VStack(alignment: .leading, spacing: 24) {
                if viewModel.infoStep >= 5 {
                    DodamTextField.default(
                        title: "전화번호 인증코드",
                        text: $viewModel.phoneCodeText
                    )
                    .makeFirstResponder()
                    .maxLength($viewModel.phoneCodeText, length: 6)
                    .keyboardType(.numberPad)
                    .onSubmit {
                        viewModel.infoStep = 6
                    }
                    .transition(.slide)
                    .animation(
                        Animation.easeIn(duration: 0.2),
                        value: viewModel.infoStep
                    )
                }
                
                if viewModel.infoStep >= 4 {
                    DodamTextField.default(
                        title: "전화번호",
                        text: $viewModel.phoneText
                    )
                    .makeFirstResponder()
                    .keyboardType(.numberPad)
                    .onSubmit {
                        viewModel.infoStep = 5
                    }
                    .transition(.slide)
                    .animation(
                        Animation.easeIn(duration: 0.2),
                        value: viewModel.infoStep
                    )
                }
                
                if viewModel.infoStep >= 3 {
                    DodamTextField.default(
                        title: "이메일 인증코드",
                        text: $viewModel.emailCodeText
                    )
                    .makeFirstResponder()
                    .maxLength($viewModel.emailCodeText, length: 6)
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
                        text: $viewModel.studentInfoText
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
            .padding(.horizontal, 16)
        }
        .safeAreaInset(edge: .bottom) {
            Group {
                let isNotEmptyStudentInfo = viewModel.infoStep == 1 && viewModel.studentInfoText.count >= 9
                let isNotEmptyPhoneCode = viewModel.infoStep == 4 && viewModel.phoneText.count == 13
                if isNotEmptyStudentInfo || isNotEmptyPhoneCode {
                    DodamButton.fullWidth(
                        title: "다음"
                    ) {
                        if isNotEmptyStudentInfo {
                            viewModel.infoStep = 2
                        } else if isNotEmptyPhoneCode {
                            viewModel.infoStep = 5
                        }
                    }
                }
                
                if viewModel.infoStep == 3 {
                    if viewModel.isSendEmailCode {
                        DodamButton.fullWidth(
                            title: "인증"
                        ) {
                            viewModel.verifyEmailCode {
                                viewModel.infoStep = 4
                            }
                        }
                        .disabled(viewModel.emailCodeText.count < 6)
                    } else {
                        DodamButton.fullWidth(
                            title: "이메일 인증코드 전송"
                        ) {
                            viewModel.sendEmailCode()
                        }
                    }
                }
                
                if viewModel.infoStep == 5 {
                    if viewModel.isSendPhoneCode {
                        DodamButton.fullWidth(
                            title: "인증"
                        ) {
                            viewModel.verifyPhoneCode {
                                flow.push(
                                    RegisterAuthView()
                                        .environmentObject(viewModel)
                                )
                            }
                        }
                        .disabled(viewModel.phoneCodeText.count < 6)
                    } else {
                        DodamButton.fullWidth(
                            title: "전화번호 인증코드 전송"
                        ) {
                            viewModel.sendPhoneCode()
                        }
                    }
                }
            }
            .padding(.bottom, 24)
            .padding(.horizontal, 16)
        }
        .onChange(of: viewModel.studentInfoText) {
            if let infoText = FormatUtil.formatMemberInfo($0) {
                viewModel.studentInfoText = infoText
            }
        }
        .onChange(of: viewModel.phoneText) {
            if let phoneText = FormatUtil.formatPhone($0) {
                viewModel.phoneText = phoneText
            }
        }
    }
}

#Preview {
    FlowPreview {
        RegisterInfoView()
    }
}
