//
//  RegisterInfoView.swift
//  DodamDodam
//
//  Created by 이민규 on 3/15/24.
//

import SwiftUI
import DDS

struct RegisterInfoView: View {
    
    @InjectObject var viewModel: RegisterViewModel
    @Flow var flow
    
    var body: some View {
        DodamNavigationBar.medium(
            title: { () -> String in
                switch viewModel.infoStep {
                case 0: "이름을\n입력해주세요"
                case 1: "학생정보를\n입력해주세요"
                case 2: "이메일을\n입력해주세요"
                default: "전화번호를\n입력해주세요"
                }
            }()
        )
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
            
            let info = viewModel.infoStep == 1 && viewModel.infoText.count >= 9
            let call = viewModel.infoStep == 3 && viewModel.phoneText.count == 13
            if info || call {
                DodamButton.fullWidth(
                    title: "다음"
                ) {
                    if info {
                        viewModel.infoStep = 2
                    } else {
                        flow.push(RegisterAuthView())
                    }
                }
                .padding(.bottom, 24)
            }
        }
        .onChange(of: viewModel.infoText) {
            switch $0.count {
            case 1: // 학년을 입력한 경우: "" (0글자)
                viewModel.infoText = "\($0[0])학년"
            case 2: // 학년을 삭제한 경우: "1학년"
                viewModel.infoText = ""
            case 4: // 반을 입력한 경우: "1학년2"
                viewModel.infoText = "\($0[0])학년 \($0[3])반"
            case 5: // 반을 삭제한 경우: "1학년 2
                viewModel.infoText = "\($0[0])학년"
            case 7: // 번호를 입력한 경우: "1학년 2반3"
                viewModel.infoText = "\($0[0])학년 \($0[4])반 \($0[6])번"
            case 8: // 번호를 삭제한 경우: "1학년 2반 3"
                viewModel.infoText = "\($0[0])학년 \($0[4])반"
            case 9: // 번호가 두 글자일 때 번호를 삭제한 경우: "1학년 2반 34"
                if viewModel.infoText[8] != "번" {
                    viewModel.infoText = "\($0[0])학년 \($0[4])반 \($0[7])번"
                }
            case 10: // 번호를 한 글자 더 추가한 경우: "1학년 2반 3번4"
                if $0[9] != "번" {
                    viewModel.infoText = "\($0[0])학년 \($0[4])반 \($0[7])\($0[9])번"
                }
            case 11...: // "1학년 2반 34번1"
                viewModel.infoText = viewModel.infoText[0..<10]
            default:
                break
            }
        }
        .onChange(of: viewModel.phoneText) {
            switch $0.count {
            case 4:
                if viewModel.phoneText[3] == "-" { // 010-
                    viewModel.phoneText = viewModel.phoneText[0..<3]
                } else { // 0108
                    viewModel.phoneText = "\(viewModel.phoneText[0..<3])-\(viewModel.phoneText[3])"
                }
            case 9:
                if viewModel.phoneText[8] == "-" { // 010-8778-
                    viewModel.phoneText = viewModel.phoneText[0..<8]
                } else { // 010-87780
                    viewModel.phoneText = "\(viewModel.phoneText[0..<8])-\(viewModel.phoneText[8])"
                }
            default:
                break
            }
        }
//        .ignoresSafeArea(.keyboard)
        .padding(.horizontal, 16)
    }
}

#Preview {
    FlowPreview {
        RegisterInfoView()
    }
}
