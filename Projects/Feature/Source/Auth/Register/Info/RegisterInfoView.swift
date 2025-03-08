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
    
    @EnvironmentObject private var viewModel: RegisterViewModel
    @EnvironmentObject private var dialog: DialogProvider
    @Flow private var flow
    
    var body: some View {
        DodamScrollView.medium(
            title: {
                switch viewModel.infoStep {
                case .name: "이름을\n입력해주세요"
                case .studentInfo: "학생정보를\n입력해주세요"
                case .phone: "전화번호를\n입력해주세요"
                case .phoneCode: "전화번호를\n인증해주세요"
                case .email: "이메일을\n입력해주세요"
                case .emailCode: "이메일을\n인증해주세요"
                }
            }()
        ) {
            VStack(alignment: .leading, spacing: 24) {
                if viewModel.infoStep >= .emailCode {
                    DodamTextField.default(
                        title: "이메일 인증코드",
                        text: $viewModel.emailCodeText
                    )
                    .makeFirstResponder()
                    .maxLength($viewModel.emailCodeText, length: 6)
                    .keyboardType(.numberPad)
                    .transition(.slide)
                    .animation(
                        Animation.easeIn(duration: 0.2),
                        value: viewModel.infoStep
                    )
                }
                
                if viewModel.infoStep >= .email {
                    DodamTextField.default(
                        title: "이메일",
                        text: $viewModel.emailText
                    )
                    .makeFirstResponder()
                    .keyboardType(.emailAddress)
                    .onSubmit {
                        viewModel.infoStep = .emailCode
                    }
                    .transition(.slide)
                    .animation(
                        Animation.easeIn(duration: 0.2),
                        value: viewModel.infoStep
                    )
                }
                
                if viewModel.infoStep >= .phoneCode {
                    DodamTextField.default(
                        title: "전화번호 인증코드",
                        text: $viewModel.phoneCodeText
                    )
                    .makeFirstResponder()
                    .maxLength($viewModel.phoneCodeText, length: 6)
                    .keyboardType(.numberPad)
                    .onSubmit {
                        viewModel.infoStep = .email
                    }
                    .transition(.slide)
                    .animation(
                        Animation.easeIn(duration: 0.2),
                        value: viewModel.infoStep
                    )
                }
                
                if viewModel.infoStep >= .phone {
                    DodamTextField.default(
                        title: "전화번호",
                        text: $viewModel.phoneText
                    )
                    .makeFirstResponder()
                    .keyboardType(.numberPad)
                    .onSubmit {
                        viewModel.infoStep = .phoneCode
                    }
                    .transition(.slide)
                    .animation(
                        Animation.easeIn(duration: 0.2),
                        value: viewModel.infoStep
                    )
                }
                
                if viewModel.infoStep >= .studentInfo && viewModel.selectedRole != .parent {
                    DodamTextField.default(
                        title: "학생정보",
                        text: $viewModel.studentInfoText
                    )
                    .makeFirstResponder()
                    .keyboardType(.numberPad)
                    .onSubmit {
                        viewModel.infoStep = .phone
                    }
                    .transition(.slide)
                    .animation(
                        Animation.easeIn(duration: 0.2),
                        value: viewModel.infoStep
                    )
                }
                
                if viewModel.infoStep >= .name {
                    DodamTextField.default(
                        title: "이름",
                        text: $viewModel.nameText
                    )
                    .makeFirstResponder()
                    .onSubmit {
                        if viewModel.selectedRole == .parent {
                            viewModel.infoStep = .phone
                        } else {
                            viewModel.infoStep = .studentInfo
                        }
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
                let isNotEmptyStudentInfo = viewModel.infoStep == .studentInfo && viewModel.studentInfoText.count >= 9
                let isNotEmptyPhoneCode = viewModel.infoStep == .phone && viewModel.phoneText.count == 13
                if isNotEmptyStudentInfo || isNotEmptyPhoneCode {
                    DodamButton.fullWidth(
                        title: "다음"
                    ) {
                        if isNotEmptyStudentInfo {
                            viewModel.infoStep = .phone
                        } else if isNotEmptyPhoneCode {
                            viewModel.infoStep = .phoneCode
                        }
                    }
                }
                
                if viewModel.infoStep == .phoneCode {
                    if viewModel.isSendPhoneCode {
                        DodamButton.fullWidth(
                            title: "인증"
                        ) {
                            await viewModel.verifyPhoneCode { result in
                                switch result {
                                case .success:
                                    if viewModel.selectedRole == .parent {
                                        flow.push(
                                            RegisterAuthView()
                                                .environmentObject(viewModel)
                                        )
                                    } else {
                                        viewModel.infoStep = .email
                                    }
                                case .failure:
                                    dialog.present(
                                        .init(title: "인증 코드가 올바르지 않습니다")
                                    )
                                }
                            }
                        }
                        .disabled(viewModel.phoneCodeText.count < 6)
                    } else {
                        DodamButton.fullWidth(
                            title: "전화번호 인증코드 전송"
                        ) {
                            await viewModel.sendPhoneCode()
                        }
                    }
                }
                
                if viewModel.infoStep == .emailCode {
                    if viewModel.isSendEmailCode {
                        DodamButton.fullWidth(
                            title: "인증"
                        ) {
                            await viewModel.verifyEmailCode { result in
                                switch result {
                                case .success:
                                    flow.push(
                                        RegisterAuthView()
                                            .environmentObject(viewModel)
                                    )
                                case .failure:
                                    dialog.present(
                                        .init(title: "인증 코드가 올바르지 않습니다")
                                    )
                                }
                            }
                        }
                        .disabled(viewModel.emailCodeText.count < 6)
                    } else {
                        DodamButton.fullWidth(
                            title: "이메일 인증코드 전송"
                        ) {
                            await viewModel.sendEmailCode()
                        }
                    }
                }
            }
            .padding(.bottom, 24)
            .padding(.horizontal, 16)
        }
        .onChange(of: viewModel.studentInfoText) {
            guard let infoText = FormatUtil.formatMemberInfo($0) else { return }
            
            viewModel.studentInfoText = infoText
        }
        .onChange(of: viewModel.phoneText) {
            guard let phoneText = FormatUtil.formatPhone($0) else { return }
            
            viewModel.phoneText = phoneText
            viewModel.infoStep = .phone
            viewModel.isSendPhoneCode = false
        }
        .onChange(of: viewModel.emailText) { _ in
            viewModel.infoStep = .email
            viewModel.isSendEmailCode = false
        }
    }
}

#Preview {
    FlowPreview {
        RegisterInfoView()
    }
}
