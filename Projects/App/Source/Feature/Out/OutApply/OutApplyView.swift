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
                            viewModel.isModalPresented.toggle()
                            focused = false
                        } label: {
                            HStack(spacing: 16) {
                                Text("\(viewModel.selection == 0 ? "외출" : "외박")날짜")
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
                            viewModel.isModalPresented.toggle()
                            focused = false
                        } label: {
                            HStack(spacing: 16) {
                                Text("복귀 날짜")
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
                isPresented: $viewModel.isModalPresented
            ) {
                if viewModel.selection == 0 {
                    // dodam picker
                    Text("시작 시간 피커")
                    DatePicker(
                        "날짜",
                        selection: $viewModel.startAt,
                        displayedComponents: [.hourAndMinute]
                    )
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden()
                } else {
                    // dodam picker
                    Text("끝 시간 피커")
                }
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
