//
//  DivisionView.swift
//  Feature
//
//  Created by hhhello0507 on 2/4/25.
//

import SwiftUI
import DDS
import FlowKit

struct DivisionView: View {
    @Flow private var flow
    
    var body: some View {
        DodamScrollView.small(
            title: "그룹"
        ) {
            LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                Section {
                    DodamTopTabView {
                        LazyVStack(spacing: 12) {
                            ForEach(["B1ND", "B2ND", "B3ND"], id: \.self) {
                                DivisionCell(name: $0) {
                                    // TODO: navigate to detail
                                }
                            }
                        }
                        .padding(8)
                        .page(.text("내 그룹"))
                        LazyVStack(spacing: 12) {
                            ForEach(["B1ND", "B2ND", "B3ND"], id: \.self) {
                                DivisionCell(name: $0) {
                                    // TODO: navigate to detail view
                                }
                            }
                        }
                        .padding(8)
                        .page(.text("전체"))
                    }
                    .padding(.top, 8)
                } header: {
                    DodamTextField.default(
                        title: "그룹 검색",
                        text: .constant("")
                    )
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .background(DodamColor.Background.normal)
                    .padding(.top, -8)
                }
            }
        }
        .button(icon: .plus) {
            flow.push(CreateDivisionView())
        }
        .background(DodamColor.Background.normal)
    }
}
