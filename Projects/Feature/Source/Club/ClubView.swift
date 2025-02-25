//
//  ClubView.swift
//  Feature
//
//  Created by dgsw30 on 2/19/25.
//

import FlowKit
import SwiftUI
import DDS
import Shared

struct ClubView: View {
    @State var selection: Int = 0
    @StateObject var viewModel = ClubViewModel()
    @DodamDialog private var dialog
    @Flow var flow
    
    var body: some View {
        DodamScrollView.default(title: "동아리") {
            VStack(spacing: 12) {
                if selection == 0 {
                    VStack {
                        if let data = viewModel.clubs?.filter({ $0.type == .activity }) {
                            if data.isEmpty {
                                VStack {
                                    Text("아직 등록된 동아리가 없어요.")
                                        .font(.label(.medium))
                                        .foreground(DodamColor.Label.alternative)
                                }
                                .frame(maxWidth: .infinity, maxHeight: 50)
                                .padding(16)
                                .background(DodamColor.Background.normal)
                                .clipShape(.medium)
                                .padding(.vertical)
                            } else {
                                ForEach(data, id: \.self) { data in
                                    ClubCell(for: data) {
                                        flow.push(ClubDetailView(id: data.id))
                                    }
                                    .padding(.vertical, 2)
                                }
                            }
                        }
                    }
                }
                if selection == 1 {
                    if let data = viewModel.clubs?.filter({ $0.type == .directActivity }) {
                        if data.isEmpty {
                            VStack {
                                Text("아직 등록된 동아리가 없어요.")
                                    .font(.label(.medium))
                                    .foreground(DodamColor.Label.alternative)
                            }
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .padding(16)
                            .background(DodamColor.Background.normal)
                            .clipShape(.medium)
                            .padding(.vertical)
                        } else {
                            ForEach(data, id: \.self) { data in
                                ClubCell(for: data) {
                                    flow.push(ClubDetailView(id: data.id))
                                }
                                .padding(.vertical, 2)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
        .subView {
            DodamSegmentedButton(
                labels: ["창체", "자율"],
                selection: $selection
            )
        }
        .button(icon: .plus) {
            //            let dialog = Dialog(title: "정말 확실합니까?")
            //                .message("창체동아리 : \n1지망 B1ND,\n2지망 ALT,\n3지망 DUKAMI\n자율동아리 :\nDrop,\nDraw !,\nInD,\n씨범자리뺏기 위 동아리로 신청을 넣겠습니까?")
            //                .primaryButton("수락") {}
            //                .secondaryButton("취소") {}
            //            self.dialog.present(dialog)
            flow.push(MyClubView())
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
    ClubView()
}
