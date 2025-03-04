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
    @Environment(\.openURL) private var openURL
    @Flow var flow
    
    var body: some View {
        DodamScrollView.default(title: "동아리") {
            VStack(spacing: 12) {
                if selection == 0 {
                    VStack {
                        if let data = viewModel.clubs?.filter({ $0.type == .activity }) {
                            if data.isEmpty {
                                DodamEmptyView(
                                    title: "아직 등록된 동아리가 없어요.",
                                    icon: .fullMoonFace,
                                    buttonTitle: "동아리 생성하기"
                                ) {
                                    if let url = URL(string: "") {
                                        openURL(url)
                                    }
                                }
                            } else {
                                ForEach(data, id: \.self) { data in
                                    ClubCell(for: data) {
                                        flow.push(ClubDetailView(id: data.id))
                                    }
                                    .padding(.vertical, 2)
                                }
                            }
                        } else {
                            DodamLoadingView()
                        }
                    }
                }
                if selection == 1 {
                    if let data = viewModel.clubs?.filter({ $0.type == .directActivity }) {
                        if data.isEmpty {
                            DodamEmptyView(
                                title: "아직 등록된 동아리가 없어요.",
                                icon: .convenienceStore,
                                buttonTitle: "동아리 생성하기"
                            ) {
                                if let url = URL(string: "") {
                                    openURL(url)
                                }
                            }
                        } else {
                            ForEach(data, id: \.self) { data in
                                ClubCell(for: data) {
                                    flow.push(ClubDetailView(id: data.id))
                                }
                                .padding(.vertical, 2)
                            }
                        }
                    } else {
                        DodamLoadingView()
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
