//
//  CreateClubCell.swift
//  Feature
//
//  Created by dgsw30 on 2/20/25.
//

import SwiftUI
import DDS
import Domain
import Shared

struct CreateClubCell: View {
    @StateObject private var viewModel = CreateClubCellViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text("내 개설 신청")
                    .font(.headline(.bold))
                    .foreground(DodamColor.Label.normal)
            }
            
            if let myClubs = viewModel.myClubs {
                if myClubs.isEmpty {
                    Text("개설한 동아리가 없습니다")
                        .font(.body2(.regular))
                        .foreground(DodamColor.Label.alternative)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, 12)
                } else {
                    let creativeClubs = myClubs.filter { $0.type == .activity }
                    let freeClubs = myClubs.filter { $0.type == .directActivity }
                    
                    VStack(alignment: .leading, spacing: 14) {
                        if !creativeClubs.isEmpty {
                            Text("창체")
                                .font(.caption2(.bold))
                                .foreground(DodamColor.Label.alternative)
                            
                            ForEach(creativeClubs, id: \.id) { club in
                                HStack {
                                    Text(club.name)
                                    Spacer()
                                    
                                    statusTag(for: club.state)
                                }
                                .font(.body2(.medium))
                                .foreground(DodamColor.Label.normal)
                            }
                        }
                        
                        if !freeClubs.isEmpty {
                            Text("자율")
                                .font(.caption2(.bold))
                                .foreground(DodamColor.Label.alternative)
                            
                            ForEach(freeClubs, id: \.id) { club in
                                HStack {
                                    Text(club.name)
                                    Spacer()
                                    
                                    statusTag(for: club.state)
                                }
                                .font(.body2(.medium))
                                .foreground(DodamColor.Label.normal) 
                            }
                        }
                    }
                    .padding(.vertical, 4)
                }
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
    
    @ViewBuilder
    func statusTag(for state: StateType) -> some View {
        switch state {
        case .allowed:
            Image(icon: .checkCircle)
        case .rejected:
            Image(icon: .redXmarkCircle)
        case .waiting, .pending:
            Image(icon: .yellowClock)
        case .deleted:
            EmptyView()
        }
    }
}

#Preview {
    CreateClubCell()
}
