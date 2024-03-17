//
//  RegisterInfoView.swift
//  DodamDodam
//
//  Created by 이민규 on 3/15/24.
//

import SwiftUI

struct RegisterInfoView: View {
    
    // UI test state
    @State var step: Int = 0
    @State var testPhoneText: String = ""
    @State var testInfoText: String = ""
    @State var testMailText: String = ""
    @State var testNameText: String = ""
    
    @InjectObject var viewModel: RegisterInfoViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text({ () -> String in
                switch step {
                case 0: "이름을"
                case 1: "학생정보를"
                case 2: "이메일"
                default: "전화번호를"
                }
            }() + "\n입력해주세요")
            .font(.dodamHeading3)
            
            if step >= 3 {
                DodamTextField.default(
                    title: "전화번호",
                    text: $testPhoneText
                )
                .makeFirstResponder()
                .onSubmit {
                    step = 4
                }
                .transition(.slide)
                .animation(
                    Animation.easeIn(duration: 0.2),
                    value: step
                )
            }
            
            if step >= 2 {
                DodamTextField.default(
                    title: "이메일",
                    text: $testMailText
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
                    title: "학생정보",
                    text: $testInfoText
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
                    title: "이름",
                    text: $testNameText
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
                title: "다음"
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
    RegisterInfoView()
}
