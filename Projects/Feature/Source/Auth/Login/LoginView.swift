//
//  LoginView.swift
//  DodamDodam
//
//  Created by 이민규 on 3/14/24.
//

import SwiftUI
import DDS
import Shared
import FlowKit

struct LoginView: View {
    
    @DodamDialog private var dialog
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
        .onChange(of: viewModel.isShowingAlert) {
            if $0 {
                let dialog = Dialog(title: "로그인 실패")
                    .message("잠시 후 다시 시도해 주세요")
                    .primaryButton("확인")
                self.dialog.present(dialog)
            }
        }
        .dodamSheet(isPresented: $viewModel.isModalPresented) {
            modalSheetView
        }
    }
    
    private var modalSheetView: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 4) {
                Text("회원가입을 하기 위해 동의가 필요해요")
                    .heading2(.bold)
                    .foreground(DodamColor.Label.normal)
                Text("도담도담에 가입하기 위해 서비스 이용약관과 개인정보처리방침 동의가 필요해요")
                    .body1(.medium)
                    .foreground(DodamColor.Label.alternative)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Spacer().frame(height: 24)
            Button {
                if viewModel.isChecked {
                    (viewModel.isChecked1, viewModel.isChecked2) = (false, false)
                } else {
                    (viewModel.isChecked1, viewModel.isChecked2) = (true, true)
                }
            } label: {
                HStack(spacing: 6) {
                    Image(icon: .checkmark)
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 20, height: 20)
                        .foreground(
                            viewModel.isChecked
                            ? DodamColor.Primary.normal
                            : DodamColor.Label.alternative
                        )
                    Text("필수 항목 모두 체크하기")
                        .body1(.bold)
                        .foreground(DodamColor.Label.neutral)
                }
                .frame(height: 48)
                .padding(.horizontal, 28)
                .frame(maxWidth: .infinity, alignment: .leading)
                .opacity(viewModel.isChecked ? 1 : 0.5)
                .foreground(DodamColor.Label.neutral)
            }
            .background(DodamColor.Fill.normal)
            .clipShape(.medium)
            Spacer().frame(height: 12)
            VStack(spacing: 0) {
                AgreeCell(
                    isChecked: viewModel.isChecked1,
                    description: "(필수) 서비스 이용약관",
                    url: "https://dodam.b1nd.com/detailed-information/personal-information"
                ) {
                    viewModel.isChecked1.toggle()
                }
                AgreeCell(
                    isChecked: viewModel.isChecked2,
                    description: "(필수) 개인정보 수집 및 이용에 대한 안내",
                    url: "https://dodam.b1nd.com/detailed-information/service-policy"
                ) {
                    viewModel.isChecked2.toggle()
                }
            }
            Spacer().frame(height: 24)
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
