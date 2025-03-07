//
//  AffiliationCell.swift
//  Feature
//
//  Created by dgsw30 on 2/20/25.
//

import SwiftUI
import DDS
import Domain
import Shared

struct AffiliationCell: View {
    @StateObject private var viewModel = AffiliationCellViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text("소속된 동아리")
                    .font(.headline(.bold))
                    .foreground(DodamColor.Label.normal)
            }
            
            if let joinedClubs = viewModel.joinedClubs {
                if joinedClubs.isEmpty {
                    Text("소속된 동아리가 없습니다")
                        .font(.body2(.regular))
                        .foreground(DodamColor.Label.alternative)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, 12)
                } else {
                    let creativeClubs = joinedClubs.filter { $0.type == .activity }
                    let freeClubs = joinedClubs.filter { $0.type == .directActivity }
                    
                    VStack(alignment: .leading, spacing: 14) {
                        if !creativeClubs.isEmpty {
                            Text("창체")
                                .font(.caption2(.bold))
                                .foreground(DodamColor.Label.alternative)
                            
                            ForEach(creativeClubs, id: \.id) { club in
                                HStack {
                                    Text(club.name)
                                    Spacer()
                                    if club.myStatus == .allowed {
                                        DodamTag("입부완료", type: .negative)
                                    } else {
                                        DodamTag("처리중", type: .negative)
                                    }
                                }
                                .font(.body2(.regular))
                                .foreground(DodamColor.Label.normal)
                                
                                if club.id != creativeClubs.last?.id {
                                    Divider()
                                        .padding(.vertical, 4)
                                }
                            }
                        }
                        
                        if !freeClubs.isEmpty {
                            if !creativeClubs.isEmpty {
                                Divider()
                                    .padding(.vertical, 8)
                            }
                            
                            Text("자율")
                                .font(.caption2(.bold))
                                .foreground(DodamColor.Label.alternative)
                            
                            ForEach(freeClubs, id: \.id) { club in
                                HStack {
                                    Text(club.name)
                                    Spacer()
                                    if club.myStatus == .allowed {
                                        DodamTag("입부완료", type: .primary)
                                    } else {
                                        DodamTag("처리중", type: .secondary)
                                    }
                                }
                                .font(.body2(.medium))
                                .foreground(DodamColor.Label.normal)
                                
                                if club.id != freeClubs.last?.id {
                                    Divider()
                                        .padding(.vertical, 4)
                                }
                            }
                        }
                    }
                    .padding(.vertical, 4)
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
        .refreshable {
            await viewModel.onRefresh()
        }
    }
}

#Preview {
    AffiliationCell()
}
