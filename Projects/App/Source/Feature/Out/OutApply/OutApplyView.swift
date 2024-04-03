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
    
    var body: some View {
        DodamNavigationBar.medium(title: "외출 외박 신청하기")
        VStack(alignment: .leading, spacing: 24) {
            SegmentedView(
                labels: ["외출", "외박"],
                selection: $viewModel.selection
            )
            .padding(.top, 6)
            DodamTextField.default(
                title: "\(viewModel.selection == 0 ? "외출" : "외박") 사유",
                text: $viewModel.reasonText
            )
            VStack(spacing: 16) {
                Button {
                    viewModel.startAt = "3월 14일"
                } label: {
                    HStack(spacing: 16) {
                        Text("\(viewModel.selection == 0 ? "외출" : "외박")날짜")
                            .font(.system(size: 18, weight: .medium))
                            .dodamColor(.tertiary)
                        Spacer()
                        Text("\(viewModel.startAt)")
                            .font(.system(size: 18, weight: .regular))
                            .dodamColor(.primary)
                        Image(icon: .chevronRight)
                            .resizable()
                            .frame(width: 14, height: 14)
                            .dodamColor(.onSurfaceVariant)
                    }
                    .frame(height: 40)
                }
                Button {
                    viewModel.endAt = "3월 14일"
                } label: {
                    HStack(spacing: 16) {
                        Text("복귀 날짜")
                            .font(.system(size: 18, weight: .medium))
                            .dodamColor(.tertiary)
                        Spacer()
                        Text("\(viewModel.endAt)")
                            .font(.system(size: 18, weight: .regular))
                            .dodamColor(.primary)
                        Image(icon: .chevronRight)
                            .resizable()
                            .frame(width: 14, height: 14)
                            .dodamColor(.onSurfaceVariant)
                    }
                    .frame(height: 40)
                }
            }
            Spacer()
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
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    OutApplyView()
}
