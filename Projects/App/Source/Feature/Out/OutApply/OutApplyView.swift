//
//  OutApplyView.swift
//  DodamDodam
//
//  Created by 이민규 on 3/21/24.
//

import SwiftUI
import DDS

struct OutApplyView: View {
    
    @InjectObject var viewModel: OutApplyViewModel
    @Flow var flow
    
    @Binding var selected: Int
    @FocusState var focused
    
    var body: some View {
        DodamScrollView.medium(title: "외출 외박 신청하기") {
            VStack(alignment: .leading, spacing: 24) {
                DodamTextField.default(
                    title: "\(selected == 0 ? "외출" : "외박") 사유",
                    text: $viewModel.reasonText
                )
                .focused($focused)
                .padding(.horizontal, 24)
                VStack(spacing: 16) {
                    if selected == 0 {
                        Button {
                            viewModel.isOutDateModalPresented.toggle()
                            focused = false
                        } label: {
                            HStack(spacing: 16) {
                                Text("외출 날짜")
                                    .font(.system(size: 18, weight: .medium))
                                    .dodamColor(.tertiary)
                                Spacer()
                                Text("\(viewModel.dateAt.parseString(format: "M월 d일 (E)"))")
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
                    Button {
                        viewModel.isStartAtModalPresented.toggle()
                        focused = false
                    } label: {
                        HStack(spacing: 16) {
                            Text(selected == 0 ? "외출 시간" : "외박 날짜")
                                .font(.system(size: 18, weight: .medium))
                                .dodamColor(.tertiary)
                            Spacer()
                            Text({ () -> String in
                                if selected == 1 {
                                    return viewModel.startAt.parseString(
                                        format: "M월 d일 (E)"
                                    )
                                }
                                return viewModel.startAt.parseString(
                                    format: "HH:mm"
                                )
                            }())
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
                        viewModel.isEndAtModalPresented.toggle()
                        focused = false
                    } label: {
                        HStack(spacing: 16) {
                            Text(selected == 0 ? "복귀 시간" : "복귀 날짜")
                                .font(.system(size: 18, weight: .medium))
                                .dodamColor(.tertiary)
                            Spacer()
                            Text({ () -> String in
                                if selected == 1 {
                                    return viewModel.endAt.parseString(
                                        format: "M월 d일 (E)"
                                    )
                                }
                                return viewModel.endAt.parseString(
                                    format: "HH:mm"
                                )
                            }())
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
                .padding(.horizontal, 16)
                Spacer()
            }
        }
        .subView {
            SegmentedView(
                labels: ["외출", "외박"],
                selection: $selected
            )
            .padding(.top, 6)
            .padding(.horizontal, 8)
        }
        .dodamModal(
            isPresented: $viewModel.isStartAtModalPresented,
            disableGesture: true
        ) {
            VStack {
                Text(selected == 0 ? "외출 일시" : "외박 날짜")
                    .font(.body(.large))
                    .dodamColor(.onBackground)
                DatePicker(
                    "시작",
                    selection: $viewModel.startAt,
                    displayedComponents: [
                        selected == 0
                        ? .hourAndMinute
                        : .date
                    ]
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
                Text(selected == 0 ? "복귀 일시" : "복귀 날짜")
                    .font(.body(.large))
                    .dodamColor(.onBackground)
                DatePicker(
                    "끝",
                    selection: $viewModel.endAt,
                    displayedComponents: [
                        selected == 0
                        ? .hourAndMinute
                        : .date
                    ]
                )
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden()
            }
        }
        .dodamModal(
            isPresented: $viewModel.isOutDateModalPresented,
            disableGesture: true
        ) {
            VStack {
                Text("외출 날짜")
                    .font(.body(.large))
                    .dodamColor(.onBackground)
                DatePicker(
                    "외출 날짜",
                    selection: $viewModel.dateAt,
                    displayedComponents: .date
                )
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden()
            }
        }
        .overlay(alignment: .bottom) {
            if !(viewModel.isStartAtModalPresented ||
                 viewModel.isEndAtModalPresented ||
                 viewModel.isOutDateModalPresented) {
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
        }
        .task {
            await viewModel.onAppear()
        }
    }
}
