//
//  MyClubView.swift
//  Feature
//
//  Created by dgsw30 on 2/19/25.
//

import SwiftUI
import DDS
import FlowKit
import Foundation

struct MyClubView: View {
    @StateObject private var viewModel = AffiliationCellViewModel()
    @Flow var flow
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    var body: some View {
        DodamScrollView.medium(title: "내동아리") {
            VStack(spacing: 0) {
                if let myApplyClub = viewModel.myApplyClub, let joinedClubs = viewModel.joinedClubs {
                    if myApplyClub.isEmpty && joinedClubs.isEmpty {
                        if let clubRegisterTime = viewModel.clubRegisterTime {
                            if let endDate = dateFormatter.date(from: clubRegisterTime.applicantEnd) {
                                VStack {
                                    if Date() <= endDate {
                                        DodamEmptyView(
                                            title: "신청 마감 : \(clubRegisterTime.applicantEnd)",
                                            icon: .fullMoonFace,
                                            buttonTitle: "동아리 입부 신청하기"
                                        ) {
                                            flow.push(ClubApplyView())
                                        }
                                    } else {
                                        DodamEmptyView(
                                            title: "신청이 마감 되었어요!",
                                            icon: .fullMoonFace,
                                            buttonTitle: "다음에 또 만나요!"
                                        ) {}
                                    }
                                }
                                .padding(16)
                            }
                        }
                    } else {
                        MyApplyCell()
                        
                        AffiliationCell()
                    }
                }
                
                CreateClubCell()
                
                SugestCell()
            }
        }
        .background(DodamColor.Background.neutral)
        .task {
            await viewModel.onAppear()
        }
    }
}

#Preview {
    MyClubView()
}
