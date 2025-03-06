//
//  ClubDetailView.swift
//  Feature
//
//  Created by dgsw30 on 2/19/25.
//

import SwiftUI
import DDS
import MarkdownUI

struct ClubDetailView: View {
    @StateObject private var viewModel: ClubDetailViewModel
    @State private var sheetHeight: CGFloat = 300
    @State private var isExpanded: Bool = false
    private let minHeight: CGFloat = 300
    private let maxHeight: CGFloat = 550
    private let sheetWidth: CGFloat = 380
    
    let id: Int
    
    init(id: Int) {
        self.id = id
        self._viewModel = StateObject(wrappedValue: ClubDetailViewModel(clubId: id))
    }
    
    var body: some View {
        DodamScrollView.medium(title: "") {
            VStack(alignment: .leading, spacing: 6) {
                if let data = viewModel.clubDetail {
                    Text(data.subject)
                        .font(.label(.medium))
                        .foreground(DodamColor.Label.alternative)
                    
                    Text(data.name)
                        .font(.heading1(.bold))
                        .foreground(DodamColor.Label.normal)
                    
                    Text(data.shortDescription)
                        .font(.body1(.medium))
                        .foreground(DodamColor.Label.normal)
                    
                    DodamDivider()
                        .padding(.vertical, 24)
                        .padding(.horizontal, 4)
                    
                    Text("설명")
                        .font(.heading2(.bold))
                        .foreground(DodamColor.Label.normal)
                        .padding(.vertical, 4)
                    
                    Markdown(data.description)
                        .font(.body1(.medium))
                        .foreground(DodamColor.Label.normal)
                }
            }
            .padding(.top, 4)
            .padding(.horizontal, 14)
        }
        .overlay(alignment: .bottom) {
            VStack {
                VStack(spacing: 0) {
                    HStack {
                        if let members = viewModel.clubMembers?.isEmpty {
                            Text(members ? "멤버" : "멤버현황")
                                .font(.headline(.bold))
                                .foreground(DodamColor.Label.normal)
                                .padding(.top, 10)
                            Spacer()
                        }
                    }
                    .padding(.leading)
                    .padding(.vertical, 10)
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 15) {
                            if let members = viewModel.clubMembers {
                                ForEach(members.indices, id: \.self) { index in
                                    let member = members[index]
                                    MemberCell(for: member)
                                        .onAppear {
                                            if index > 1 && !isExpanded {
                                                withAnimation(.spring()) {
                                                    sheetHeight = maxHeight
                                                    isExpanded = true
                                                }
                                            }
                                        }
                                }
                            } else if let leaderMembers = viewModel.leaderMembers {
                                ForEach(leaderMembers.indices, id: \.self) { index in
                                    let leaderMember = leaderMembers[index]
                                    LeaderCell(for: leaderMember)
                                        .onAppear {
                                            if index > 1 && !isExpanded {
                                                withAnimation(.spring()) {
                                                    sheetHeight = maxHeight
                                                    isExpanded = true
                                                }
                                            }
                                        }
                                }
                            }
                        }
                        .padding()
                        .overlay {
                            GeometryReader { geo in
                                Color .clear
                                    .onAppear {
                                        let offset = geo.frame(in: .named("스크롤상단 감지")).minY
                                        if offset >= 0 && isExpanded {
                                            withAnimation(.spring(duration: 0.1)) {
                                                sheetHeight = minHeight
                                                isExpanded = false
                                            }
                                        } else if offset < -20 && !isExpanded {
                                            withAnimation(.spring()) {
                                                sheetHeight = maxHeight
                                                isExpanded = true
                                            }
                                        }
                                    }
                            }
                        }
                    }
                    .coordinateSpace(name: "스크롤상단 감지")
                }
                .frame(maxWidth: .infinity, maxHeight: sheetHeight)
                .background(DodamColor.Background.normal)
                .clipShape(.extraSmall)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            let newHeight = sheetHeight - value.translation.height
                            if newHeight >= minHeight, newHeight <= maxHeight {
                                sheetHeight = newHeight
                            }
                        }
                        .onEnded { value in
                            withAnimation(.spring(duration: 0.1)) {
                                if value.translation.height < -50 {
                                    sheetHeight = maxHeight
                                    isExpanded = true
                                } else {
                                    sheetHeight = minHeight
                                    isExpanded = false
                                }
                            }
                        }
                )
            }
            .padding(.horizontal, 6)
        }
        .background(DodamColor.Background.neutral)
        .task {
            await viewModel.onAppear()
        }
    }
}
