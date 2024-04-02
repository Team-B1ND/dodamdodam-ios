//
//  WakeupSongView.swift
//  DodamDodam
//
//  Created by dgsw8th71 on 4/1/24.
//

import SwiftUI
import DDS

enum WakeupSongTabType {
    case waiting
    case my
}

struct WakeupSongView: View {
    
    @InjectObject var viewModel: WakeupSongViewModel
    @Flow var flow
    @State private var showDeleteWakeupDialog = false
    
    @State private var rect: CGRect = .zero
    
    @State private var testTomorrowWakeupSongs = Array(0..<3)
    @State private var testWaitingWakeupSongs = Array(0..<10)
    @State private var testMyWakeupSongs = Array(0..<2)
    
    @State private var selectedTab: WakeupSongTabType = .waiting
    
    var body: some View {
        DodamScrollView.medium(title: "기상송") {
            VStack(alignment: .leading, spacing: 0) {
                Text("내일의 기상송")
                    .font(.title(.medium))
                    .dodamColor(.onBackground)
                if let data = viewModel.allowedWakeupSongData,
                   !data.isEmpty {
                    LazyVStack(spacing: 4) {
                        ForEach(data, id: \.self) { data in
                            TomorrowWakeupSongCell(
                                data: data
                            )
                        }
                    }
                    .padding(.top, 12)
                    .padding(.bottom, 6)
                } else {
                    Text("승인된 기상송이 아직 없어요.")
                        .font(.label(.large))
                        .dodamColor(.tertiary)
                        .frame(
                            maxWidth: .infinity,
                            alignment: .center
                        )
                        .padding(.vertical, 40)
                }
                LazyVStack(pinnedViews: [.sectionHeaders]) {
                    DodamTopTabView {
                        LazyVStack(spacing: 4) {
                            if let data = viewModel.pendingWakeupSongData,
                               !data.isEmpty {
                                ForEach(data, id: \.self) { data in
                                    WakeupSongCell(
                                        data: data
                                    )
                                }
                            }
                            Spacer()
                        }
                        .padding(.top, 12)
                        .padding(.bottom, 150)
                        .page(.text("대기중"))
                        
                        LazyVStack(spacing: 4) {
                            if let data = viewModel.myWakeupSongData {
                                ForEach(data, id: \.self) { data in
                                    WakeupSongCell(
                                        data: data
                                    )
                                }
                            }
                            Spacer()
                        }
                        .padding(.top, 12)
                        .padding(.bottom, 150)
                        .page(.text("MY"))
                    }
                    .padding(.top, 15)
                    Spacer()
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 150)
        }
        .button(icon: .plus) {
            flow.push(WakeupSongApplyView())
        }
        .task {
            await viewModel.onAppear()
        }
    }
}

#Preview {
    FlowPreview {
        WakeupSongView()
    }
}
