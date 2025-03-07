//
//  MyClubView.swift
//  Feature
//
//  Created by dgsw30 on 2/19/25.
//

import SwiftUI
import DDS
import FlowKit

struct MyClubView: View {
    @StateObject private var viewModel = AffiliationCellViewModel()
    @Flow var flow
    
    var body: some View {
        DodamScrollView.medium(title: "내동아리") {
            VStack {
                if let myApplyClub = viewModel.myApplyClub, let joinedClubs = viewModel.joinedClubs {
                    if !myApplyClub.isEmpty && !joinedClubs.isEmpty {
                        DodamEmptyView(
                            title: "아직 동아리에 신청하지 않았어요!\n신청 마감 : 2025. 03. 19.",
                            icon: .fullMoonFace,
                            buttonTitle: "동아리 입부 신청하기"
                        ) {
                            flow.push(ClubApplyView())
                        }
                        .padding(.vertical)
                    } else {
                        MyApplyCell()
                        
                        AffiliationCell()
                    }
                }
            }
                
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
