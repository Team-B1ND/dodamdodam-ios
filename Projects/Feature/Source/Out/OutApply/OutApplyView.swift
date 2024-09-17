//
//  OutApplyView.swift
//  DodamDodam
//
//  Created by 이민규 on 3/21/24.
//

import SwiftUI
import DDS
import FlowKit
import Shared

struct OutApplyView: View {
    
    @DodamTimePicker private var timePicker
    @DodamDatePicker private var datePicker
    @StateObject var viewModel = OutApplyViewModel()
    @Flow var flow
    
    // 0: 외출
    // 1: 외박
    @Binding var selected: Int
    @FocusState var focused
    
    var body: some View {
        DodamScrollView.medium(title: "외출 외박 신청하기") {
            VStack(alignment: .leading, spacing: 24) {
                DodamTextField.default(
                    title: "\(selected == 0 ? "외출" : "외박") 사유",
                    text: $viewModel.reasonText
                )
                .makeFirstResponder()
                .focused($focused)
                .padding(.horizontal, 24)
                VStack(spacing: 16) {
                    if selected == 0 {
                        Button {
                            let datePicker = DatePicker(title: "외출 날짜", startDate: .now, endDate: .distantFuture) {
                                viewModel.dateAt = self.datePicker.date
                            }
                            self.datePicker.present(datePicker, date: viewModel.dateAt)
                            focused = false
                        } label: {
                            HStack(spacing: 12) {
                                Text("외출 날짜")
                                    .headline(.medium)
                                    .foreground(DodamColor.Label.alternative)
                                Spacer()
                                Text("\(viewModel.dateAt.parseString(format: "M월 d일 (E)"))")
                                    .headline(.regular)
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
                    }
                    Button {
                        if selected == 0 {
                            let timePicker = TimePicker(title: "외출 일시") {
                                viewModel.startAt = self.timePicker.date
                            }
                            self.timePicker.present(timePicker, date: viewModel.startAt)
                        } else {
                            let datePicker = DatePicker(title: "외박 날짜", startDate: .now, endDate: .distantFuture) {
                                viewModel.startAt = self.datePicker.date
                            }
                            self.datePicker.present(datePicker, date: viewModel.startAt)
                        }
                        focused = false
                    } label: {
                        HStack(spacing: 12) {
                            Text(selected == 0 ? "외출 시간" : "외박 날짜")
                                .headline(.medium)
                                .foreground(DodamColor.Label.alternative)
                            Spacer()
                            Text(viewModel.startAt.parseString(format: selected == 1 ? "M월 d일 (E)" : "HH:mm"))
                                .headline(.regular)
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
                        if selected == 0 {
                            let timePicker = TimePicker(title: "복귀 일시") {
                                viewModel.endAt = self.timePicker.date
                            }
                            self.timePicker.present(timePicker, date: viewModel.endAt)
                        } else {
                            let datePicker = DatePicker(title: "복귀 날짜", startDate: .now, endDate: .distantFuture) {
                                viewModel.endAt = self.datePicker.date
                            }
                            self.datePicker.present(datePicker, date: viewModel.endAt)
                        }
                        focused = false
                    } label: {
                        HStack(spacing: 12) {
                            Text(selected == 0 ? "복귀 시간" : "복귀 날짜")
                                .headline(.medium)
                                .foreground(DodamColor.Label.alternative)
                            Spacer()
                            Text(viewModel.endAt.parseString(format: selected == 1 ? "M월 d일 (E)" : "HH:mm"))
                                .headline(.regular)
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
                }
                .padding(.horizontal, 16)
                Spacer()
            }
        }
        .subView {
            DodamSegmentedButton(
                labels: ["외출", "외박"],
                selection: $selected
            )
            .padding(.top, 6)
            .padding(.horizontal, 8)
        }
        .overlay(alignment: .bottom) {
            DodamButton.fullWidth(
                title: "확인"
            ) {
                if selected == 0 {
                    await viewModel.postOutGoing()
                } else {
                    await viewModel.postOutSleeping()
                }
                flow.pop()
            }
            .disabled(
                viewModel.reasonText.isEmpty ||
                viewModel.startAt >= viewModel.endAt
            )
            .padding(.bottom, 8)
            .padding(.horizontal, 16)
        }
        .task {
            await viewModel.onAppear()
        }
    }
}
