//
//  DivisionView.swift
//  Feature
//
//  Created by hhhello0507 on 2/4/25.
//

import SwiftUI
import DDS
import FlowKit
import Shared

struct DivisionView: View {
    static let pagingInterval = 10
    
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
                                    .task {
                                        guard let index = divisions.findIndex(id: division.id) else {
                                            return
                                        }
                                        
                                        if PagingUtil.isLastPage(index: index, pagingInterval: Self.pagingInterval, count: divisions.count) {
                                            await viewModel.fetchMyDivisions(lastId: division.id)
                                        }
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
                                    .task {
                                        guard let index = divisions.findIndex(id: division.id) else {
                                            return
                                        }
                                        
                                        if PagingUtil.isLastPage(index: index, pagingInterval: Self.pagingInterval, count: divisions.count) {
                                            await viewModel.fetchDivisions(lastId: division.id)
                                        }
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
        // TODO: 마감 후 구현
//        .button(icon: .plus) {
//            flow.push(CreateDivisionView())
//        }
        .background(DodamColor.Background.normal)
        .hideKeyboardWhenTap()
        .simultaneousGesture(DragGesture().onChanged({ _ in
            hideKeyboard()
        }))
        .task {
            await viewModel.onAppear()
        }
        .refreshable {
            await viewModel.onRefresh()
        }
    }
}
