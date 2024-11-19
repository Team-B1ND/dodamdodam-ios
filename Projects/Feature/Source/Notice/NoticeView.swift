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
    var body: some View {
        ZStack {
            DodamScrollView.default(title: "공지") {
                LazyVStack(pinnedViews: [.sectionHeaders]) {
                    Section(header: CategoryCell(categories: ["전체"])) {
                        ForEach(0..<5, id: \.self) { _ in
                            NotificationCell(title: "hi", content: "안녕", user: "이윤채", date: "2월 10일 수요일")
                                .padding(.horizontal, 16)
                                .padding(.top, 12)
                        }
                    }
                }
            }
            .clipped()
            .background(DodamColor.Background.neutral)
            
            VStack {
                HStack {
                    Spacer()
                    Button {
                    } label: {
                        Image(icon: .magnifyingGlass)
                            .resizable()
                            .frame(width: 23, height: 23)
                    }
                    .foreground(DodamColor.Label.alternative)
                    .padding(.trailing, 16)
                    .padding(.top, 16)
                }
                Spacer()
            }
        }
    }
}
