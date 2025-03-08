//
//  ApplyCell.swift
//  Feature
//
//  Created by dgsw30 on 2/20/25.
//

import SwiftUI
import DDS
import Domain

struct MyApplyCell: View {
    @StateObject private var viewModel = MyApplyCellViewModel()
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text("내신청")
                    .font(.headline(.bold))
                    .foreground(DodamColor.Label.normal)
            }
            
            if let applyClub = viewModel.myApplyClub {
                if applyClub.isEmpty {
                    Text("신청한 동아리가 없습니다")
                        .font(.body2(.regular))
                        .foreground(DodamColor.Label.alternative)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, 12)
                } else {
                    let creativeClubs = applyClub.filter { $0.club.type == .activity }
                    let freeClubs = applyClub.filter { $0.club.type == .directActivity }
                    
                    if !creativeClubs.isEmpty {
                        VStack(alignment: .leading, spacing: 14) {
                            Text("창체")
                                .font(.caption2(.bold))
                                .foreground(DodamColor.Label.alternative)
                            
                            ForEach(ClubPriority.allCases, id: \.self) { priority in
                                if let club = creativeClubs.first(where: { $0.priority == priority }) {
                                    HStack {
                                        Text("\(priorityLabel(priority))지망")
                                        Spacer()
                                        Text(club.club.name)
                                    }
                                    .font(.body2(.medium))
                                    .foreground(DodamColor.Label.normal)
                                }
                            }
                        }
                        .padding(.vertical, 16)
                    }
                    
                    DodamDivider()
                        .padding(.vertical, 2)
                    
                    if !freeClubs.isEmpty {
                        VStack(alignment: .leading, spacing: 14) {
                            Text("자율")
                                .font(.caption2(.bold))
                                .foreground(DodamColor.Label.alternative)
                            
                            VStack(alignment: .leading, spacing: 14) {
                                ForEach(freeClubs, id: \.id) { freeClub in
                                    Text(freeClub.club.name)
                                }
                            }
                            .font(.body2(.medium))
                            .foreground(DodamColor.Label.normal)
                        }
                        .padding(.vertical, 8)
                    }
                }
            } else {
                DodamLoadingView()
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(DodamColor.Background.normal)
        .clipShape(.medium)
        .padding(16)
        .task {
            await viewModel.onAppear()
        }
    }
}

func priorityLabel(_ priority: ClubPriority) -> String {
    switch priority {
    case .first: return "1"
    case .second: return "2"
    case .third: return "3"
    }
}

#Preview {
    MyApplyCell()
}
