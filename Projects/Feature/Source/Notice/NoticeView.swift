//
//  NoticeView.swift
//  Feature
//
//  Created by dgsw8th61 on 11/5/24.
//

import SwiftUI
import DDS
import Shared

struct NoticeView: View {
    static let pagingInterval = 30
    
    @StateObject private var viewModel = NoticeViewModel()

    var body: some View {
        DodamScrollView.default(
            title: "공지"
        ) {
            if let notices = viewModel.notices {
                LazyVStack(spacing: 12) {
                    ForEach(notices, id: \.id) { notice in
                        NoticeCell(notice: notice)
                            .task {
                                guard let index = notices.firstIndex(where: { $0.id == notice.id }) else { return }
                                
                                if PagingUtil.isLastPage(index: index, pagingInterval: Self.pagingInterval, count: notices.count) {
                                    await viewModel.fetchNotices(lastId: notice.id)
                                }
                            }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 12)
            } else {
                DodamLoadingView()
                    .padding(.vertical, 40)
            }
        }
        .subView {
            if let myDivisions = viewModel.myDivisions {
                NoticeViewHeader(
                    selectedDivision: $viewModel.selectedDivision,
                    divisions: myDivisions
                )
                .padding([.horizontal, .bottom], -16) // TODO: Fix DDS
            } else {
                DodamLoadingView()
                    .padding(.vertical, 20)
            }
        }
        .refreshable {
            await viewModel.onRefresh()
        }
        .background(DodamColor.Background.neutral)
        .task {
            await viewModel.onAppear()
        }
    }
}
