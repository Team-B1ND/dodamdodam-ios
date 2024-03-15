//
//  RegisterInfoView.swift
//  DodamDodam
//
//  Created by 이민규 on 3/15/24.
//

import SwiftUI

struct RegisterInfoView: View {
    
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
                case 0: return "이름을"
                case 1: return "학생정보를"
                case 2: return "이메일"
                case 3: return "전화번호를"
                default: return ""
                }
            }() + "\n입력해주세요")
            .font(.heading3)
            
            if step >= 0 {
                DodamTextField.default(
                    title: "이름",
                    text: $testNameText
                )
                .makeFirstResponder()
            }
            if step >= 1 {
                DodamTextField.default(
                    title: "학생정보",
                    text: $testInfoText
                )
                .makeFirstResponder()
            }
            if step >= 2 {
                DodamTextField.default(
                    title: "이메일",
                    text: $testMailText
                )
                .makeFirstResponder()
            }
            if step >= 3 {
                DodamTextField.default(
                    title: "전화번호",
                    text: $testPhoneText
                )
                .makeFirstResponder()
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
