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
    @ObservedObject var viewModel: NightStudyApplyViewModel
    @Flow var flow
    @FocusState var focused
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            DodamTextField.default(
                title: "심야 자습 사유",
                text: $viewModel.reasonText
            )
            .makeFirstResponder()
            .padding(.bottom, 22)
            .padding(.horizontal, 8)
            .focused($focused)
            .overlay(alignment: .bottomLeading) {
                if viewModel.reasonText.count < 10 {
                    Text("10글자 이상 입력하세요")
                        .font(.system(size: 14, weight: .regular))
                        .foreground(DodamColor.Status.negative)
                        .padding(.horizontal, 8)
                }
            }
            
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
                                    NightStudyPlace.allCases,
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
                        endDate: Calendar.current.date(byAdding: .day, value: 0, to: self.datePicker.date.addingTimeInterval(.infinity)) ?? .now
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
                        startDate: viewModel.startAt,
                        endDate: Calendar.current.date(byAdding: .day, value: 13, to: viewModel.startAt) ?? .now
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
    }
}
