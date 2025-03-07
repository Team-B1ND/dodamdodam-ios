//
//  ClubDetailView.swift
//  Feature
//
//  Created by dgsw30 on 2/19/25.
//

import SwiftUI
import DDS
import MarkdownUI
import FlowKit

struct ClubDetailView: View {
    @StateObject private var viewModel: ClubDetailViewModel
    @State private var sheetHeight: CGFloat = 300
    
    @Flow var flow
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
                } else {
                    Text("창체")
                        .font(.label(.medium))
                        .foreground(DodamColor.Label.alternative)
                        .shimmer()
                    
                    Text("바인드")
                        .font(.heading1(.bold))
                        .foreground(DodamColor.Label.normal)
                        .shimmer()
                    
                    Text("세계최고 동아리 바인드")
                        .font(.body1(.medium))
                        .foreground(DodamColor.Label.normal)
                        .shimmer()
                    
                    DodamDivider()
                        .padding(.vertical, 24)
                        .padding(.horizontal, 4)
                    
                    Markdown("바인드 최고!")
                        .font(.body1(.medium))
                        .foreground(DodamColor.Label.normal)
                        .shimmer()
                }
            }
            .padding(.top, 4)
            .padding(.horizontal, 14)
            .padding(.bottom, sheetHeight)
        }
        .overlay(alignment: .bottom) {
            VStack {
                VStack(spacing: 0) {
                    HStack {
                        if let members = viewModel.clubMembers?.isLeader {
                            Text(members ? "멤버현황" : "멤버")
                                .font(.headline(.bold))
                                .foreground(DodamColor.Label.normal)
                                .padding(.top, 10)
                            Spacer()
                            
                            if let membersCount = viewModel.clubMembers?.students.count {
                                Text("\(membersCount)명")
                                    .font(.headline(.bold))
                                    .foreground(DodamColor.Label.normal)
                                    .padding(.horizontal)
                            }
                        }
                    }
                    .padding(.leading)
                    .padding(.vertical, 10)
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 15) {
                            if let clubMembers = viewModel.clubMembers {
                                ForEach(clubMembers.students.indices, id: \.self) { index in
                                    let member = clubMembers.students[index]
                                    if clubMembers.isLeader {
                                        LeaderCell(for: member)
                                    } else {
                                        MemberCell(for: member)
                                    }
                                }
                            } else {
                                ForEach(1...10, id: \.self) { _ in
                                    HStack {
                                        Rectangle()
                                            .frame(width: 32, height: 32)
                                            .clipShape(.extraLarge)
                                            .shimmer()
                                            .padding(.horizontal, 1)
                                        
                                        Text("김은찬")
                                            .shimmer()
                                        
                                        Spacer()
                                        
                                        Text("2-1")
                                            .shimmer()
                                    }
                                    .padding(.horizontal, 4)
                                }
                            }
                        }
                        .padding()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: sheetHeight)
                .background(DodamColor.Background.normal)
                .clipShape(.extraSmall)
                .padding(.horizontal, 6)
                
                DodamButton.fullWidth(
                    title: "입부 신청하기"
                ) {
                    flow.push(ClubApplyView())
                }
                .padding([.bottom, .horizontal], 16)
            }
        }
        
        .background(DodamColor.Background.neutral)
        .task {
            await viewModel.onAppear()
        }
    }
}
