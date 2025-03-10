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
    @StateObject private var viewModel = MyClubViewModel()
    @Environment(\.openURL) private var openURL
    @DodamDialog private var dialog
    @Flow var flow
    
    var body: some View {
        DodamScrollView.medium(title: "내동아리") {
            VStack(spacing: 0) {
                if let clubRegisterTime = viewModel.clubRegisterTime {
                    let dateFormatter = DateFormatter(type: .isoDate)
                    
                    let applyClub = viewModel.myApplyClub?.isEmpty ?? false
                    let joinedClub = viewModel.joinedClubs?.isEmpty ?? false
                    if let endDate = dateFormatter.date(from: clubRegisterTime.applicantEnd) {
                        let isApplicationOpen = Date() <= endDate
                        let title = isApplicationOpen ? "신청 마감 : \(clubRegisterTime.applicantEnd)" : "신청이 마감 되었어요!"
                        let buttonTitle = isApplicationOpen ? "동아리 입부 신청하기" : "다음에 또 만나요!"
                        let action: () -> Void = {
                            if isApplicationOpen {
                                if applyClub && joinedClub {
                                    flow.push(ClubApplyView())
                                } else {
                                    let dialog = Dialog(
                                        title: "추가 신청은 웹으로 해주세요",
                                        message: "도담도담 웹으로 추가 신청하러 가기"
                                    )
                                        .primaryButton("수락") {
                                            if let url = URL(string: "https://dodam.b1nd.com/club/register") {
                                                openURL(url)
                                            }
                                        }
                                        .secondaryButton("취소") {}
                                    self.dialog.present(dialog)
                                }
                            }
                        }
                        
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
            
            AffiliationCell(for: viewModel)
            
            MyApplyCell(for: viewModel)
            
            CreateClubCell(for: viewModel)
            
            SugestCell(for: viewModel)
        }
        .background(DodamColor.Background.neutral)
        .task {
            await viewModel.onAppear()
        }
        .refreshable {
            await viewModel.onRefresh()
        }
    }
}

#Preview {
    MyClubView()
}
