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
    
    //    @InjectObject var viewModel: WakeupSongViewModel
    @Flow var flow
    @State private var showDeleteWakeupDialog = false
    
    @State private var rect: CGRect = .zero
    
    @State private var testTomorrowWakeupSongs = Array(0..<3)
    @State private var testWaitingWakeupSongs = Array(0..<10)
    @State private var testMyWakeupSongs = Array(0..<2)
    
    @State private var selectedTab: WakeupSongTabType = .waiting
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 0) {
                    HStack {
                        Text("내일의 기상송")
                            .font(.title(.medium))
                            .padding(.leading, 16)
                        Spacer()
                    }
                    if testTomorrowWakeupSongs.isEmpty {
                        Text("승인된 기상송이 아직 없어요.")
                            .font(.label(.large))
                            .dodamColor(.tertiary)
                            .padding(.vertical, 40)
                    } else {
                        tomorrowWakeupSongList
                            .padding(.top, 12)
                            .padding(.bottom, 6)
                    }
                    LazyVStack(pinnedViews: [.sectionHeaders]) {
                        // temp indicator
                        Section(header: tabIndicator) {
                            TabView(selection: $selectedTab) {
                                waitingWakeUpSongList
                                    .tag(WakeupSongTabType.waiting)
                                    .background(GeometryReader {
                                        Color.clear.preference(key: ViewRectKey.self,
                                                               value: [$0.frame(in: .local)])
                                    })
                                myWakeUpSongList
                                    .tag(WakeupSongTabType.my)
                                    .background(GeometryReader {
                                        Color.clear.preference(key: ViewRectKey.self,
                                                               value: [$0.frame(in: .local)])
                                    })
                            }
                            .tabViewStyle(.page(indexDisplayMode: .never))
                            .frame(height: rect.size.height + 12)
                            .onPreferenceChange(ViewRectKey.self) { rects in
                                if rects.first?.height != .zero {
                                    rect = rects.first ?? .zero
                                }
                            }
                        }
                        Spacer()
                    }
                }
            }
            .clipped()
            
            VStack {
                Spacer()
                DodamButton.fullWidth(
                    title: "기상송 신청하기"
                ) {
                    // action
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 8)
            }
        }
        .navigationBarHidden(false)
    }
    
    @ViewBuilder
    private var tomorrowWakeupSongList: some View {
        LazyVStack(spacing: 4) {
            ForEach(Array(testTomorrowWakeupSongs.enumerated()), id: \.element) { idx, _ in
                TomorrowWakeupSongCell(rank: idx + 1)
                    .padding(.horizontal, 16)
            }
        }
    }
    
    @ViewBuilder
    private var tabIndicator: some View {
        HStack {
            Spacer()
            Button("대기중") {
                selectedTab = .waiting
            }
            Spacer()
            Button("MY") {
                selectedTab = .my
            }
            Spacer()
        }
        .background(Color.white)
    }
    
    @ViewBuilder
    private var waitingWakeUpSongList: some View {
        LazyVStack(spacing: 4) {
            ForEach(testWaitingWakeupSongs, id: \.self) { _ in
                WakeupSongCell()
                    .padding(.horizontal, 16)
                    .onLongPressGesture {
                        showDeleteWakeupDialog = true
                    }
            }
            Spacer()
        }
        .padding(.bottom, 48)
    }
    
    @ViewBuilder
    private var myWakeUpSongList: some View {
        LazyVStack(spacing: 4) {
            ForEach(testMyWakeupSongs, id: \.self) { _ in
                WakeupSongCell()
                    .padding(.horizontal, 16)
                    .onLongPressGesture {
                        showDeleteWakeupDialog = true
                    }
            }
            Spacer()
        }
        .padding(.bottom, 48)
    }
}

#Preview {
    WakeupSongView()
}

public struct ViewRectKey: PreferenceKey {
    public typealias Value = [CGRect]
    public static var defaultValue = [CGRect]()
    public static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
