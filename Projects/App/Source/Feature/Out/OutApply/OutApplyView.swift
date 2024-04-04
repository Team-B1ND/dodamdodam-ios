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
    @FocusState var focused
    
    var body: some View {
        ZStack(alignment: .bottom) {
            DodamScrollView.medium(title: "외출 외박 신청하기") {
                VStack(alignment: .leading, spacing: 24) {
                    DodamTextField.default(
                        title: "\(viewModel.selection == 0 ? "외출" : "외박") 사유",
                        text: $viewModel.reasonText
                    )
                    .focused($focused)
                    .padding(.horizontal, 24)
                    VStack(spacing: 16) {
                        Button {
                            viewModel.isStartAtModalPresented.toggle()
                            focused = false
                        } label: {
                            HStack(spacing: 16) {
                                Text(viewModel.selection == 0 ? "외출 일시" : "외박 날짜")
                                    .font(.system(size: 18, weight: .medium))
                                    .dodamColor(.tertiary)
                                Spacer()
                                Text("\(viewModel.startDate)")
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
                                Text(viewModel.selection == 0 ? "복귀 일시" : "복귀 날짜")
                                    .font(.system(size: 18, weight: .medium))
                                    .dodamColor(.tertiary)
                                Spacer()
                                Text("\(viewModel.endDate)")
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
                    selection: $viewModel.selection
                )
                .padding(.top, 6)
                .padding(.horizontal, 8)
            }
            .dodamModal(
                isPresented: $viewModel.isStartAtModalPresented,
                disableGesture: true
            ) {
                VStack {
                    Text(viewModel.selection == 0 ? "외출 일시" : "외박 날짜")
                        .font(.body(.large))
                        .dodamColor(.onBackground)
                    DatePicker(
                        "시작",
                        selection: $viewModel.startAt,
                        displayedComponents: [
                            viewModel.selection == 0 
                            ? .hourAndMinute
                            : .date, .hourAndMinute
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
                    Text(viewModel.selection == 0 ? "복귀 일시" : "복귀 날짜")
                        .font(.body(.large))
                        .dodamColor(.onBackground)
                    DatePicker(
                        "끝",
                        selection: $viewModel.endAt,
                        displayedComponents: [
                            viewModel.selection == 0
                            ? .hourAndMinute
                            : .date, .hourAndMinute
                        ]
                    )
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden()
                }
            }
            if !(viewModel.isStartAtModalPresented ||
                viewModel.isEndAtModalPresented) {
                DodamButton.fullWidth(
                    title: "확인"
                ) {
                    await viewModel.onTapApplyButton()
                    flow.pop()
                }
                .disabled(
                    viewModel.reasonText.isEmpty
                )
                .padding(.bottom, 8)
                .padding(.horizontal, 16)
            }
        }
        .task {
            viewModel.onAppear()
        }
    }
}

#Preview {
    OutApplyView()
}
