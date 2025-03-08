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
import Shared

struct MyClubView: View {
    @StateObject private var viewModel = AffiliationCellViewModel()
    @Flow var flow
    
    var body: some View {
        DodamScrollView.medium(title: "내동아리") {
            VStack(spacing: 0) {
                if let clubRegisterTime = viewModel.clubRegisterTime {
                    let dateFormatter = DateFormatter(type: .isoDate)
                    
                    if let endDate = dateFormatter.date(from: clubRegisterTime.applicantEnd) {
                        let isApplicationOpen = Date() <= endDate
                        let title = isApplicationOpen ? "신청 마감 : \(clubRegisterTime.applicantEnd)" : "신청이 마감 되었어요!"
                        let buttonTitle = isApplicationOpen ? "동아리 입부 신청하기" : "다음에 또 만나요!"
                        let action: () -> Void = isApplicationOpen ? { flow.push(ClubApplyView()) } : {}
                        
                        VStack {
                            DodamEmptyView(
                                title: title,
                                icon: .fullMoonFace,
                                buttonTitle: buttonTitle,
                                action: action
                            )
                        }
                        .padding(16)
                    }
                }
            }
            
            AffiliationCell()
            
            MyApplyCell()
            
            CreateClubCell()
            
            SugestCell()
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
