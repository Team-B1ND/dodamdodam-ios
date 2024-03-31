//
//  OnboardingView.swift
//  DodamDodam
//
//  Created by 이민규 on 3/13/24.
//

import SwiftUI
import DDS

struct OnboardingView: View {
    
    @InjectObject var viewModel: OnboardingViewModel
    @Flow var flow
    
    var body: some View {
        VStack {
            VStack(spacing: 16) {
                Dodam.icon(.logo)
                    .resizable()
                    .scaledToFit()
                    .dodamColor(.onPrimary)
                Text("어린아이가 탈 없이 잘 놀며 자라는 모양.")
                    .font(.body(.medium))
                    .dodamColor(.onPrimary)
            }
            .frame(height: 85)
            .padding(.top, 80)
            Spacer()
            VStack(spacing: 16) {
                DodamButton.fullWidth(
                    title: "로그인"
                ) {
                    flow.push(LoginView())
                }
                .padding(.horizontal, 16)
                
                HStack(spacing: 0) {
                    Text("처음 이용하시나요? ")
                        .font(.body(.small))
                    Button {
                        viewModel.onTapRegisterButton()
                    } label: {
                        Text("회원가입")
                            .font(.system(size: 14, weight: .bold))
                            .underline()
                    }
                }
                .dodamColor(.onPrimary)
            }
            .padding(.bottom, 16)
        }
        .background(
            Image(.onboard)
                .resizable()
                .offset(x: -UIScreen.main.bounds.width / 9)
                .scaledToFill()
                .frame(maxHeight: .infinity)
                .ignoresSafeArea()
        )
        .dodamModal(isPresented: $viewModel.isModalPresented) {
            modalSheetView
        }
    }
    
    private var modalSheetView: some View {
        VStack(spacing: 12) {
            Button {
                if viewModel.isChecked() == true {
                    (viewModel.isChecked1, viewModel.isChecked2) = (false, false)
                } else {
                    (viewModel.isChecked1, viewModel.isChecked2) = (true, true)
                }
            } label: {
                HStack(spacing: 14) {
                    Dodam.icon(.checkmarkCircle)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .dodamColor(
                            viewModel.isChecked()
                            ? .primary
                            : .outline
                        )
                        .padding(.leading, 18)
                        .padding(.vertical, 12)
                    Text("모두 동의합니다")
                        .font(.body(.medium))
                        .dodamColor(.onBackground)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Dodam.color(.outline), lineWidth: 1.5)
                }
            }
            VStack(spacing: 4) {
                HStack(spacing: 4) {
                    Button {
                        viewModel.isChecked1.toggle()
                    } label: {
                        Dodam.icon(.checkmark)
                            .resizable()
                            .frame(width: 24, height: 24)
                            .dodamColor(
                                viewModel.isChecked1
                                ? .primary
                                : .outline
                            )
                    }
                    Link(
                        destination: URL(string: "https://dodam.b1nd.com/detailed-information/personal-information")!
                    ) {
                        Text("(필수) 서비스 이용약관")
                            .font(.body(.small))
                            .dodamColor(.tertiary)
                        Spacer()
                        Dodam.icon(.chevronRight)
                            .resizable()
                            .frame(width: 16, height: 16)
                            .dodamColor(.onSurfaceVariant)
                    }
                }
                .frame(height: 32)
                
                HStack(spacing: 4) {
                    Button {
                        viewModel.isChecked2.toggle()
                    } label: {
                        Dodam.icon(.checkmark)
                            .resizable()
                            .frame(width: 24, height: 24)
                            .dodamColor(
                                viewModel.isChecked2
                                ? .primary
                                : .outline
                            )
                    }
                    Link(
                        destination: URL(string: "https://dodam.b1nd.com/detailed-information/service-policy")!
                    ) {
                        Text("(필수) 개인정보 수집 및 이용에 대한 안내")
                            .font(.body(.small))
                            .dodamColor(.tertiary)
                        Spacer()
                        Dodam.icon(.chevronRight)
                            .resizable()
                            .frame(width: 16, height: 16)
                            .dodamColor(.onSurfaceVariant)
                    }
                }
                .frame(height: 32)
            }
            DodamButton.fullWidth(
                title: "다음"
            ) {
                flow.push(RegisterInfoView())
                viewModel.isModalPresented = false
            }
            .disabled(!viewModel.isChecked())
        }
        .background(Dodam.color(.background))
    }
}

#Preview {
    FlowPreview {
        OnboardingView()
    }
}
