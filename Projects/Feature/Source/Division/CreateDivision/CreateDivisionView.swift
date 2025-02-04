//
//  CreateDivisionView.swift
//  Feature
//
//  Created by hhhello0507 on 2/4/25.
//

import SwiftUI
import DDS
import FlowKit
import Shared

struct CreateDivisionView: View {
    @StateObject private var viewModel = CreateDivisionViewModel()
    @EnvironmentObject private var dialog: DialogProvider
    @Flow private var flow
    
    private var isValidDivisionDescription: Bool {
        viewModel.description.count <= 300
    }
    
    var body: some View {
        DodamScrollView.small(
            title: "새 그룹 만들기"
        ) {
            LazyVStack(spacing: 8) {
                DodamTextField.default(
                    title: "그룹 이름",
                    text: $viewModel.divisionName
                )
                // TODO: to Textarea
                DodamTextField.default(
                    title: "그룹 설명",
                    text: $viewModel.description
                )
                // TODO: Add Max length
                HStack(spacing: 0) {
                    Spacer()
                    Text("\(viewModel.description.count)")
                        .font(.body1(.medium))
                        .foreground(
                            isValidDivisionDescription
                            ? DodamColor.Primary.normal
                            : DodamColor.Status.negative
                        )
                    Text("/300")
                        .font(.body1(.medium))
                        .foreground(
                            isValidDivisionDescription
                            ? DodamColor.Label.assistive
                            : DodamColor.Status.negative
                        )
                }
            }
            .padding(.top, 8)
            .padding(.horizontal, 16)
        }
        .safeAreaInset(edge: .bottom) {
            DodamButton.fullWidth(
                title: "만들기"
            ) {
                await viewModel.createDivision {
                    dialog.present(
                        .init(title: "그룹 만들기 성공")
                        .primaryButton("닫기") {
                            flow.pop()
                        }
                    )
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 12)
        }
    }
}
