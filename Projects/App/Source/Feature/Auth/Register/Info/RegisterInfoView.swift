//
//  RegisterInfoView.swift
//  DodamDodam
//
//  Created by 이민규 on 3/15/24.
//

import SwiftUI
import DDS

struct RegisterInfoView: View {
    
    // UI test state
    @State var step: Int = 0
    @State var testPhoneText: String = ""
    @State var testInfoText: String = ""
    @State var testMailText: String = ""
    @State var testNameText: String = ""
    
    @InjectObject var viewModel: RegisterInfoViewModel
    @Flow var flow
    
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
            .font(.headline(.small))
            
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
                .keyboardType(.numberPad)
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
            
            if step >= 4 {
                DodamButton.fullWidth(
                    title: "다음"
                ) {
                    flow.push(RegisterAuthView())
                }
                .padding(.bottom, 24)
            }
        }
        .onChange(of: testInfoText) {
            
            switch $0.count {
            case 1: // 학년을 입력한 경우: "" (0글자)
                testInfoText = "\($0[0])학년"
            case 2: // 학년을 삭제한 경우: "1학년"
                testInfoText = ""
            case 4: // 반을 입력한 경우: "1학년2"
                testInfoText = "\($0[0])학년 \($0[3])반"
            case 5: // 반을 삭제한 경우: "1학년 2
                testInfoText = "\($0[0])학년"
            case 7: // 번호를 입력한 경우: "1학년 2반3"
                testInfoText = "\($0[0])학년 \($0[4])반 \($0[6])번"
            case 8: // 번호를 삭제한 경우: "1학년 2반 3"
                testInfoText = "\($0[0])학년 \($0[4])반"
            case 9: // 번호가 두 글자일 때 번호를 삭제한 경우: "1학년 2반 34"
                if testInfoText[8] != "번" {
                    testInfoText = "\($0[0])학년 \($0[4])반 \($0[7])번"
                }
            case 10: // 번호를 한 글자 더 추가한 경우: "1학년 2반 3번4"
                if $0[9] != "번" {
                    testInfoText = "\($0[0])학년 \($0[4])반 \($0[7])\($0[9])번"
                }
            case 11...: // "1학년 2반 34번1"
                testInfoText = testInfoText[0..<10]
            default:
                break
            }
        }
        .padding(.horizontal, 16)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                if step == 1 && testInfoText.count >= 9 {
                    Button("완료") {
                        step = 2
                    }
                }
            }
        }
        //        .ignoresSafeArea(.keyboard)
    }
}

#Preview {
    RegisterInfoView()
}
