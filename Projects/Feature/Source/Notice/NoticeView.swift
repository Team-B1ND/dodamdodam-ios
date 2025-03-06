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
    @StateObject private var viewModel = NoticeViewModel()

    var body: some View {
        ZStack(alignment: .top) {
            ScrollView {
                VStack {
                    HStack {
                        Text("공지")
                            .font(.system(size: 24, weight: .bold))
                            .foreground(DodamColor.Label.normal)
                            .padding(.leading, 16)
                        
                        Spacer()
                        
//                        Button {
//                            //
//                        } label: {
//                            Image(icon: .magnifyingGlass)
//                                .resizable()
//                                .frame(width: 28, height: 28)
//                        }
//                        .padding(.trailing, 16)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(DodamColor.Background.neutral)
                    .ignoresSafeArea(edges: .top)
                    
                    LazyVStack(pinnedViews: [.sectionHeaders]) {
                        Section(header: CategoryCell(
                            selectedCategory: $viewModel.selectedCategoryId,
                            categories: categoryList(),
                            onSelectCategory: { id in
                                viewModel.selectCategory(id)
                            }
                        )) {
                            if let notices = viewModel.notices {
                                ForEach(notices, id: \.id) { notice in
                                    let imageArray = notice.fileUrl != nil ? [notice.fileUrl!] : nil
                                    
                                    NotificationCell(
                                        title: notice.title,
                                        content: notice.content,
                                        user: notice.memberInfoRes.name,
                                        date: formatDate(notice.createdAt),
                                        images: imageArray
                                    )
                                    .padding(.horizontal, 16)
                                    .padding(.top, 12)
                                    .task {
                                        guard let index = notices.firstIndex(where: { $0.id == notice.id }) else { return }
                                        if PagingUtil.isLastPage(index: index, pagingInterval: 10, count: notices.count) {
                                            await viewModel.fetchNotices(lastId: notice.id)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .clipped()
            .background(DodamColor.Background.neutral)
        }
        .task {
            await viewModel.fetchAllData()
        }
    }
    
    private func categoryList() -> [(id: Int?, name: String)] {
        var categories: [(id: Int?, name: String)] = [ (nil, "전체") ]
        if let myDivisions = viewModel.myDivisions {
            for division in myDivisions where !division.name.isEmpty {
                categories.append((id: division.id, name: division.name))
            }
        }
        return categories
    }

    private func formatDate(_ isoDate: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone.current

        if let date = formatter.date(from: isoDate) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateFormat = "yyyy년 MM월 dd일"
            displayFormatter.locale = Locale(identifier: "ko_KR")
            return displayFormatter.string(from: date)
        }
        return "날짜 오류"
    }
}
