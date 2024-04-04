//
//  NightStudyApplyView.swift
//  DodamDodam
//
//  Created by 이민규 on 3/28/24.
//

import SwiftUI
import DDS

struct NightStudyApplyView: View {
    
    @InjectObject var viewModel: NightStudyApplyViewModel
    @Flow var flow
    @FocusState var focused
    
    var body: some View {
        ZStack(alignment: .bottom) {
            DodamButton.fullWidth(
                title: "확인"
            ) {
                flow.pop()
            }
            .disabled(
                false
            )
            .padding(.bottom, 8)
            .padding(.horizontal, 16)
            DodamScrollView.medium(title: "심야 자습 신청하기") {
                VStack(alignment: .leading, spacing: 24) {
                    DodamTextField.default(
                        title: "심야 자습 사유",
                        text: $viewModel.testText1
                    )
                    .padding(.top, 16)
                    .padding(.horizontal, 8)
                    
                    VStack(spacing: 16) {
                        Button {
                            focused = false
                        } label: {
                            HStack(spacing: 16) {
                                Text("시작 날짜")
                                    .font(.system(size: 18, weight: .medium))
                                    .dodamColor(.tertiary)
                                Spacer()
                                Text("3월 3일")
                                    .font(.system(size: 18, weight: .regular))
                                    .dodamColor(.primary)
                                Image(icon: .chevronRight)
                                    .resizable()
                                    .frame(width: 14, height: 14)
                                    .dodamColor(.onSurfaceVariant)
                            }
                            .contentShape(Rectangle())
                            .padding(.horizontal, 8)
                            .frame(height: 40)
                        }
                        .scaledButtonStyle()
                        Button {
                            focused = false
                        } label: {
                            HStack(spacing: 16) {
                                Text("종료 날짜")
                                    .font(.system(size: 18, weight: .medium))
                                    .dodamColor(.tertiary)
                                Spacer()
                                Text("3월 10일")
                                    .font(.system(size: 18, weight: .regular))
                                    .dodamColor(.primary)
                                Image(icon: .chevronRight)
                                    .resizable()
                                    .frame(width: 14, height: 14)
                                    .dodamColor(.onSurfaceVariant)
                            }
                            .contentShape(Rectangle())
                            .padding(.horizontal, 8)
                            .frame(height: 40)
                        }
                        .scaledButtonStyle()
                    }
                    
                    if viewModel.isUsePhone {
                        DodamTextField.default(
                            title: "휴대폰 사용 사유",
                            text: $viewModel.testText2
                        )
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 150)
            }
        }
    }
}

#Preview {
    NightStudyApplyView()
}
