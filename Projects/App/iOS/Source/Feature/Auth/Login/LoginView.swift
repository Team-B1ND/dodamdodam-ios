//
//  LoginView.swift
//  DodamDodam
//
//  Created by 이민규 on 3/14/24.
//

import SwiftUI
import DDS

struct LoginView: View {
    
    @StateObject var viewModel = LoginViewModel()
    @FocusState var idFocsused: Bool
    @FocusState var pwFocsused: Bool
    @Flow var flow
    
    var body: some View {
        VStack(spacing: 0) {
            DodamTopAppBar.medium(
                title: "아이디와 비밀번호를\n입력해주세요"
            )
            VStack(spacing: 24) {
                DodamTextField.default(
                    title: "아이디",
                    text: $viewModel.idText
                )
                .makeFirstResponder()
                .focused($idFocsused)
                .keyboardType(.asciiCapable)
                DodamTextField.secured(
                    title: "비밀번호",
                    text: $viewModel.pwText
                )
                .focused($pwFocsused)
                HStack(spacing: 0) {
                    Text("계정이 없으신가요? ")
                        .foreground(DodamColor.Label.alternative)
                    Button {
                        idFocsused = false
                        pwFocsused = false
                        viewModel.isModalPresented = true
                    } label: {
                        Text("회원가입")
                            .underline()
                            .foreground(DodamColor.Label.normal)
                    }
                    .scaledButtonStyle()
                }
                .label(.medium)
                DodamButton.fullWidth(
                    title: "로그인"
                ) {
                    await viewModel.postLogin {
                        flow.replace([
                            MainView()
                        ])
                    }
                }
                .disabled(!viewModel.isValidIdAndPw())
                Spacer()
            }
            .padding(.horizontal, 16)
        }
        .alert("실패", isPresented: $viewModel.isShowingAlert) {
            Button("확인", role: .none) { }
        } message: {
            Text("로그인에 실패했습니다.")
        }
        .dodamModal(isPresented: $viewModel.isModalPresented) {
            modalSheetView
        }
    }
    
    private var modalSheetView: some View {
        VStack(spacing: 12) {
            Button {
                if viewModel.isChecked == true {
                    (viewModel.isChecked1, viewModel.isChecked2) = (false, false)
                } else {
                    (viewModel.isChecked1, viewModel.isChecked2) = (true, true)
                }
            } label: {
                HStack(spacing: 14) {
                    Dodam.icon(.checkmarkCircle)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foreground(
                            viewModel.isChecked
                            ? DodamColor.Primary.normal
                            : DodamColor.Label.alternative
                        )
                        .opacity(
                            viewModel.isChecked
                            ? 1
                            : 0.5
                        )
                        .padding(.leading, 18)
                        .padding(.vertical, 12)
                    Text("모두 동의합니다")
                        .font(.body(.medium))
                        .foreground(DodamColor.Label.normal)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .background(DodamColor.Fill.normal)
                .clipShape(.small)
            }
            VStack(spacing: 4) {
                HStack(spacing: 4) {
                    Button {
                        viewModel.isChecked1.toggle()
                    } label: {
                        Dodam.icon(.checkmark)
                            .resizable()
                            .frame(width: 16, height: 16)
                            .foreground(
                                viewModel.isChecked
                                ? DodamColor.Primary.normal
                                : DodamColor.Label.alternative
                            )
                            .opacity(
                                viewModel.isChecked
                                ? 1
                                : 0.5
                            )
                    }
                    Link(
                        destination: URL(string: "https://dodam.b1nd.com/detailed-information/personal-information")!
                    ) {
                        Text("(필수) 서비스 이용약관")
                            .body(.regular)
                            .foreground(DodamColor.Label.alternative)
                            .opacity(0.5)
                        Spacer()
                        Dodam.icon(.chevronRight)
                            .resizable()
                            .frame(width: 16, height: 16)
                            .foreground(DodamColor.Label.alternative)
                    }
                }
                .frame(height: 32)
                
                HStack(spacing: 4) {
                    Button {
                        viewModel.isChecked2.toggle()
                    } label: {
                        Dodam.icon(.checkmark)
                            .resizable()
                            .frame(width: 16, height: 16)
                            .foreground(
                                viewModel.isChecked
                                ? DodamColor.Primary.normal
                                : DodamColor.Label.alternative
                            )
                            .opacity(
                                viewModel.isChecked
                                ? 1
                                : 0.5
                            )
                    }
                    Link(
                        destination: URL(string: "https://dodam.b1nd.com/detailed-information/service-policy")!
                    ) {
                        Text("(필수) 개인정보 수집 및 이용에 대한 안내")
                            .body(.regular)
                            .foreground(DodamColor.Label.alternative)
                            .opacity(0.5)
                        Spacer()
                        Dodam.icon(.chevronRight)
                            .resizable()
                            .frame(width: 16, height: 16)
                            .foreground(DodamColor.Label.alternative)
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
            .disabled(!viewModel.isChecked)
        }
        .background(DodamColor.Background.normal)
    }
}

#Preview {
    FlowPreview {
        LoginView()
    }
}
