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
            VStack(spacing: 0) {
                HStack {
                    Text("내일의 기상송")
                        .font(.title(.medium))
                        .padding(.leading, 16)
                    Spacer()
                }
                if let data = viewModel.allowedWakeupSongData,
                   !data.isEmpty {
                    LazyVStack(spacing: 4) {
                        ForEach(data, id: \.self) { data in
                            TomorrowWakeupSongCell(
                                data: data
                            )
                            .padding(.horizontal, 16)
                        }
                    }
                    .padding(.top, 12)
                    .padding(.bottom, 6)
                } else {
                    Text("승인된 기상송이 아직 없어요.")
                        .font(.label(.large))
                        .dodamColor(.tertiary)
                        .padding(.vertical, 40)
                }
                LazyVStack(pinnedViews: [.sectionHeaders]) {
                    // temp indicator
                    Section(header: tabIndicator) {
                        TabView(selection: $selectedTab) {
                            LazyVStack(spacing: 4) {
                                if let data = viewModel.pendingWakeupSongData,
                                   !data.isEmpty {
                                    ForEach(data, id: \.self) { data in
                                        WakeupSongCell(
                                            data: data
                                        )
                                        .padding(.horizontal, 16)
                                        .onLongPressGesture {
                                            showDeleteWakeupDialog = true
                                        }
                                    }
                                }
                                Spacer()
                            }
                            .padding(.bottom, 150)
                            .tag(WakeupSongTabType.waiting)
                            .background(GeometryReader {
                                Color.clear.preference(
                                    key: ViewRectKey.self,
                                    value: [$0.frame(in: .local)]
                                )
                            })
                            
                            LazyVStack(spacing: 4) {
                                if let data = viewModel.myWakeupSongData {
                                    ForEach(data, id: \.self) { data in
                                        WakeupSongCell(
                                            data: data
                                        )
                                        .padding(.horizontal, 16)
                                        .onLongPressGesture {
                                            showDeleteWakeupDialog = true
                                        }
                                    }
                                }
                                Spacer()
                            }
                            .padding(.bottom, 150)
                            .tag(WakeupSongTabType.my)
                            .background(GeometryReader {
                                Color.clear.preference(
                                    key: ViewRectKey.self,
                                    value: [$0.frame(in: .local)]
                                )
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
        .button(icon: .plus) {
            flow.push(WakeupSongApplyView())
        }
        .task {
            await viewModel.onAppear()
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
}

#Preview {
    FlowPreview {
        WakeupSongView()
    }
}

public struct ViewRectKey: PreferenceKey {
    public typealias Value = [CGRect]
    public static var defaultValue = [CGRect]()
    public static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
