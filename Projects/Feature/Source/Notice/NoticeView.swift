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
        ZStack(alignment: .top) {
            ScrollView {
                VStack {
                    HStack {
                        Text("공지")
                            .font(.system(size: 24, weight: .bold))
                            .foreground(DodamColor.Label.normal)
                            .padding(.leading, 16)
                        
                        Spacer()
                        
                        Button {
                            //
                        } label: {
                            Image(icon: .magnifyingGlass)
                                .resizable()
                                .frame(width: 28, height: 28)
                        }
                        .padding(.trailing, 16)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(DodamColor.Background.neutral)
                    .ignoresSafeArea(edges: .top)
                    
                    LazyVStack(pinnedViews: [.sectionHeaders]) {
                        Section(header: CategoryCell(categories: ["전체"])) {
                            ForEach(0..<5, id: \.self) { _ in
                                NotificationCell(
                                    title: "hi",
                                    content: "안녕",
                                    user: "이윤채",
                                    date: "2월 10일 수요일"
                                )
                                .padding(.horizontal, 16)
                                .padding(.top, 12)
                            }
                        }
                    }
                }
            }
            .clipped()
            .background(DodamColor.Background.neutral)
        }
    }
}
