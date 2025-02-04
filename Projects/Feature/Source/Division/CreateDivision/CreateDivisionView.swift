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
    @State private var divisionName: String = ""
    @State private var divisionDescription: String = ""

    @Flow private var flow
    
    private var isValidDivisionDescription: Bool {
        divisionDescription.count <= 300
    }
    
    var body: some View {
        DodamScrollView.small(
            title: "새 그룹 만들기"
        ) {
            LazyVStack(spacing: 8) {
                DodamTextField.default(
                    title: "그룹 이름",
                    text: $divisionName
                )
                // TODO: to Textarea
                DodamTextField.default(
                    title: "그룹 설명",
                    text: $divisionDescription
                )
                // TODO: Add Max length
                HStack(spacing: 0) {
                    Spacer()
                    Text("\(divisionDescription.count)")
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
                // TODO: Create division
                flow.pop()
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 12)
        }
    }
}
