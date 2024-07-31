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
    
    @DodamDatePicker private var datePicker
    @DodamDialog private var dialog
    @StateObject var viewModel = NightStudyApplyViewModel()
    @Flow var flow
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
                            .headline(.medium)
                            .font(.system(size: 18, weight: .medium))
                            .foreground(DodamColor.Label.alternative)
                        Spacer()
                        Menu {
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
                        } label: {
                            HStack(spacing: 4) {
                                Text("\(viewModel.place.rawValue)")
                                    .headline(.regular)
                                    .foreground(DodamColor.Primary.normal)
                                VStack(spacing: -4) {
                                    Image(icon: .chevronLeft)
                                        .resizable()
                                        .frame(width: 12, height: 12)
                                        .rotationEffect(.degrees(90))
                                    Image(icon: .chevronLeft)
                                        .resizable()
                                        .frame(width: 12, height: 12)
                                        .rotationEffect(.degrees(-90))
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 8)
                    .frame(height: 40)
                    Button {
                        let datePicker = DatePicker(
                            title: "시작 날짜",
                            startDate: .now,
                            endDate: Calendar.current.date(byAdding: .day, value: 6, to: .now) ?? .now
                        ) {
                            viewModel.startAt = self.datePicker.date
                        }
                        self.datePicker.present(datePicker, date: viewModel.startAt, monthDate: viewModel.startAt)
                        focused = false
                    } label: {
                        HStack(spacing: 12) {
                            Text("시작 날짜")
                                .font(.system(size: 18, weight: .medium))
                                .foreground(DodamColor.Label.alternative)
                                .headline(.medium)
                            Spacer()
                            Text(
                                viewModel.startAt.parseString(
                                    format: "M월 d일"
                                )
                            )
                            .headline(.regular)
                            .font(.system(size: 18, weight: .regular))
                            .foreground(DodamColor.Primary.normal)
                            Image(icon: .calendar)
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foreground(DodamColor.Primary.normal)
                        }
                        .padding(.horizontal, 8)
                        .frame(height: 40)
                    }
                    .scaledButtonStyle()
                    Button {
                        let datePicker = DatePicker(
                            title: "종료 날짜",
                            startDate: .now,
                            endDate: Calendar.current.date(byAdding: .day, value: 6, to: .now) ?? .now
                        ) {
                            viewModel.endAt = self.datePicker.date
                        }
                        self.datePicker.present(datePicker, date: viewModel.endAt, monthDate: viewModel.endAt)
                        focused = false
                    } label: {
                        HStack(spacing: 12) {
                            Text("종료 날짜")
                                .font(.system(size: 18, weight: .medium))
                                .foreground(DodamColor.Label.alternative)
                            Spacer()
                            Text(
                                viewModel.endAt.parseString(
                                    format: "M월 d일"
                                )
                            )
                            .headline(.regular)
                            .font(.system(size: 18, weight: .regular))
                            .foreground(DodamColor.Primary.normal)
                            Image(icon: .calendar)
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foreground(DodamColor.Primary.normal)
                        }
                        .padding(.horizontal, 8)
                        .frame(height: 40)
                    }
                    .scaledButtonStyle()
                    HStack(spacing: 0) {
                        Text("휴대폰 사용")
                            .font(.system(size: 18, weight: .medium))
                            .foreground(DodamColor.Label.alternative)
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
        }
        .overlay(alignment: .bottom) {
            DodamButton.fullWidth(
                title: "확인"
            ) {
                await viewModel.postNightStudy()
                flow.pop()
            }
            .disabled(
                viewModel.startAt > viewModel.endAt ||
                viewModel.endAt.timeIntervalSinceReferenceDate - viewModel.startAt.timeIntervalSinceReferenceDate > 86400 * 13 ||
                viewModel.reasonText.count < 10
            )
            .onChange(of: viewModel.nightStudyApplyFailed) { _ in
                let dialog = Dialog(title: "실패")
                    .message(viewModel.nightStudyApplyAlertMessage)
                    .primaryButton("확인")
                self.dialog.present(dialog)
            }
            .padding(.bottom, 8)
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    NightStudyApplyView()
}
