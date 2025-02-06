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
        VStack(spacing: 0) {
            DodamTopAppBar.small(
                title: "새 그룹 만들기"
            )
            VStack(spacing: 0) {
                VStack(spacing: 8) {
                    DodamTextField.default(
                        title: "그룹 이름",
                        text: $viewModel.divisionName
                    )
                    DodamTextField.editor(
                        title: "그룹 설명",
                        text: $viewModel.description
                    )
                    .frame(height: 300)
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
                Spacer()
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
                .disabled(!viewModel.isValidInput)
                .padding(.bottom, 12)
            }
            .padding(.horizontal, 16)
        }
        .background(DodamColor.Background.normal)
        .hideKeyboardWhenTap()
        .ignoresSafeArea(.keyboard)
    }
}
