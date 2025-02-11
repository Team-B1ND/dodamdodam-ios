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
    @StateObject private var viewModel = DivisionViewModel()
    
    var body: some View {
        DodamScrollView.small(
            title: "그룹"
        ) {
            LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                Section {
                    DodamTopTabView {
                        LazyVStack(spacing: 12) {
                            if let divisions = viewModel.searchedMyDivisions {
                                ForEach(divisions, id: \.self) { division in
                                    DivisionCell(for: division) {
                                        flow.push(DivisionDetailView(divisionId: division.id))
                                    }
                                }
                            } else {
                                DodamLoadingView()
                                    .padding(.vertical, 40)
                            }
                        }
                        .padding(8)
                        .page(.text("내 그룹"))
                        LazyVStack(spacing: 12) {
                            if let divisions = viewModel.searchedDivisions {
                                ForEach(divisions, id: \.self) { division in
                                    DivisionCell(for: division) {
                                        flow.push(DivisionDetailView(divisionId: division.id))
                                    }
                                }
                            } else {
                                DodamLoadingView()
                                    .padding(.vertical, 40)
                            }
                        }
                        .padding(8)
                        .page(.text("전체"))
                    }
                    .padding(.top, 8)
                } header: {
                    DodamTextField.default(
                        title: "그룹 검색",
                        text: $viewModel.searchText
                    )
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .background(DodamColor.Background.normal)
                    .padding(.top, -8)
                    .padding(.bottom, 8)
                }
            }
        }
        .button(icon: .plus) {
            flow.push(CreateDivisionView())
        }
        .background(DodamColor.Background.normal)
        .task {
            await viewModel.onAppear()
        }
    }
}
