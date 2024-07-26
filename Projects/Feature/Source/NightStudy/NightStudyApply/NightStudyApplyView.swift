//
//  NightStudyApplyView.swift
//  DodamDodam
//
//  Created by 이민규 on 3/28/24.
//

import SwiftUI
import DDS
import Domain
import FlowKit
import Shared

struct NightStudyApplyView: View {
    
    @StateObject var viewModel = NightStudyApplyViewModel()
    @Shared.Flow var flow
    @FocusState var focused
    
    var body: some View {
        DodamScrollView.medium(title: "심야 자습 신청하기") {
            VStack(alignment: .leading, spacing: 24) {
                DodamTextField.default(
                    title: "심야 자습 사유",
                    text: $viewModel.reasonText
                )
                .makeFirstResponder()
                .padding(.top, 16)
                .padding(.horizontal, 8)
                .focused($focused)
                
                VStack(spacing: 16) {
                    HStack(spacing: 16) {
                        Text("자습 장소")
                            .font(.system(size: 18, weight: .medium))
//                            .dodamColor(.tertiary)
                        Spacer()
                        Picker(
                            "시작 날짜",
                            selection: $viewModel.place,
                            content: {
                                ForEach(
                                    Place.allCases,
                                    id: \.self
                                ) { place in
                                    Text(place.rawValue)
                                }
                            }
                        )
                        .labelsHidden()
                    }
                    .padding(.horizontal, 8)
                    .frame(height: 40)
                    Button {
                        viewModel.isStartAtModalPresented.toggle()
                        focused = false
                    } label: {
                        HStack(spacing: 16) {
                            Text("시작 날짜")
                                .font(.system(size: 18, weight: .medium))
//                                .dodamColor(.tertiary)
                            Spacer()
                            Text(
                                viewModel.startAt.parseString(
                                    format: "M월 d일"
                                )
                            )
                            .font(.system(size: 18, weight: .regular))
//                            .dodamColor(.primary)
                            Image(icon: .chevronRight)
                                .resizable()
                                .frame(width: 14, height: 14)
//                                .dodamColor(.onSurfaceVariant)
                        }
                        .padding(.horizontal, 8)
                        .frame(height: 40)
                    }
                    .scaledButtonStyle()
                    Button {
                        viewModel.isEndAtModalPresented.toggle()
                        focused = false
                    } label: {
                        HStack(spacing: 16) {
                            Text("종료 날짜")
                                .font(.system(size: 18, weight: .medium))
//                                .dodamColor(.tertiary)
                            Spacer()
                            Text(
                                viewModel.endAt.parseString(
                                    format: "M월 d일"
                                )
                            )
                            .font(.system(size: 18, weight: .regular))
//                            .dodamColor(.primary)
                            Image(icon: .chevronRight)
                                .resizable()
                                .frame(width: 14, height: 14)
//                                .dodamColor(.onSurfaceVariant)
                        }
                        .padding(.horizontal, 8)
                        .frame(height: 40)
                    }
                    .scaledButtonStyle()
                    HStack(spacing: 0) {
                        Text("휴대폰 사용")
                            .font(.system(size: 18, weight: .medium))
//                            .dodamColor(.tertiary)
                        Spacer()
                        DodamCheckbox(isChecked: $viewModel.doNeedPhone)
                    }
                    .padding(.horizontal, 8)
                    .frame(height: 40)
                    if viewModel.doNeedPhone {
                        DodamTextField.default(
                            title: "휴대폰 사용 사유",
                            text: $viewModel.reasonForPhoneText
                        )
                        .padding(.horizontal, 8)
                        .focused($focused)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 150)
        }
        .dodamModal(
            isPresented: $viewModel.isStartAtModalPresented,
            disableGesture: true
        ) {
            VStack {
                Text("시작 날짜")
//                    .font(.body(.large))
//                    .dodamColor(.onBackground)
                DatePicker(
                    "시작 날짜",
                    selection: $viewModel.startAt,
                    displayedComponents: .date
                )
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden()
            }
        }
        .dodamModal(
            isPresented: $viewModel.isEndAtModalPresented,
            disableGesture: true
        ) {
            VStack {
                Text("종료 날짜")
//                    .font(.body(.large))
//                    .dodamColor(.onBackground)
                DatePicker(
                    "종료 날짜",
                    selection: $viewModel.endAt,
                    displayedComponents: .date
                )
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden()
            }
        }
        .overlay(alignment: .bottom) {
            if !(viewModel.isStartAtModalPresented ||
                 viewModel.isEndAtModalPresented) {
                DodamButton.fullWidth(
                    title: "확인"
                ) {
                    await viewModel.postNightStudy()
                    flow.pop()
                }
                .disabled(
                    viewModel.startAt > viewModel.endAt ||
                    viewModel.endAt.timeIntervalSinceReferenceDate -  viewModel.startAt.timeIntervalSinceReferenceDate > 86400 * 13 ||
                    viewModel.reasonText.count < 10
                )
                .alert("실패", isPresented: $viewModel.nightStudyApplyFailed) {
                    Button("확인", role: .none) { }
                } message: {
                    Text("\(viewModel.nightStudyApplyAlertMessage)")
                }
                .padding(.bottom, 8)
                .padding(.horizontal, 16)
            }
        }
    }
}

#Preview {
    NightStudyApplyView()
}
