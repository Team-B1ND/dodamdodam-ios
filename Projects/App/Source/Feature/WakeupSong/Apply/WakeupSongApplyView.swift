//
//  WakeupSongApplyView.swift
//  DodamDodam
//
//  Created by dgsw8th71 on 4/1/24.
//

import SwiftUI
import DDS
import CachedAsyncImage

struct WakeupSongApplyView: View {
    
    @InjectObject var viewModel: WakeupSongApplyViewModel
    
    var body: some View {
        DodamScrollView.medium(title: "기상송을\n검색해주세요") {
            VStack(alignment: .leading, spacing: 0) {
                if let data = viewModel.wakeupSongSearchData,
                   !viewModel.isSearchLoading {
                    LazyVStack(spacing: 4) {
                        ForEach(data, id: \.self) { data in
                            Button {
                                Task {
                                    await viewModel.postWakeupSong(
                                        videoUrl: data.videoUrl
                                    )
                                }
                            } label: {
                                HStack(spacing: 16) {
                                    CachedAsyncImage(url: URL(string: data.thumbnail)) {
                                        $0
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 120, height: 67)
                                    } placeholder: {
                                        Rectangle()
                                            .frame(width: 120, height: 67)
                                            .shimmer()
                                    }
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .padding(.vertical, 8)
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text("\(data.videoTitle)")
                                            .font(.body(.medium))
                                            .dodamColor(.onSurface)
                                            .lineLimit(1)
                                        Text("\(data.channelTitle)")
                                            .font(.label(.large))
                                            .dodamColor(.onSurfaceVariant)
                                            .lineLimit(1)
                                    }
                                    .padding(.vertical, 12)
                                    Spacer()
                                }
                            }
                            .scaledButtonStyle()
                        }
                    }
                    .padding(.bottom, 40)
                } else {
                    if !viewModel.keywordText.isEmpty,
                       viewModel.isSearchLoading {
                        DodamLoadingView()
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 40)
                    }
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text("이런 노래는 어떤가요?")
                        .font(.title(.medium))
                        .dodamColor(.onSurface)
                    Text("요즘 인기있는 노래를 바로 신청해보세요")
                        .font(.body(.small))
                        .dodamColor(.onSurface)
                }
                .padding(.top, 20)
                LazyVStack(spacing: 4) {
                    if let data = viewModel.wakeupSongChartData {
                        ForEach(data, id: \.self) { data in
                            Button {
                                Task {
                                    await viewModel.postWakeupSongByKeyword(
                                        artist: data.artist,
                                        title: data.name
                                    )
                                }
                            } label: {
                                HStack(spacing: 16) {
//                                    Text("\(data.rank)")
//                                        .font(.label(.large))
//                                        .dodamColor(.onBackground)
//                                        .frame(width: 25, height: 20)
                                    CachedAsyncImage(url: URL(
                                        string: data.thumbnail
                                    )) {
                                        $0
                                            .resizable()
                                            .frame(width: 67, height: 67)
                                    } placeholder: {
                                        Rectangle()
                                            .frame(width: 67, height: 67)
                                            .shimmer()
                                    }
                                    .clipShape(
                                        RoundedRectangle(cornerRadius: 4)
                                    )
                                    .padding(.vertical, 8)
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text("\(data.name)")
                                            .font(.body(.medium))
                                            .dodamColor(.onSurface)
                                            .lineLimit(1)
                                        Text("\(data.artist)")
                                            .font(.label(.large))
                                            .dodamColor(.onSurfaceVariant)
                                            .lineLimit(1)
                                    }
                                    .padding(.vertical, 12)
                                    Spacer()
                                }
                            }
                            .scaledButtonStyle()
                        }
                    }
                }
                .padding(.top, 16)
            }
            .padding(.bottom, 150)
            .padding(.horizontal, 16)
        }
        .subView {
            DodamTextField.default(
                title: "제목, 아티스트 혹은 링크",
                text: $viewModel.keywordText
            )
            .onSubmit {
                Task {
                    await viewModel.fetchWakeupSongByKeyword(
                        keyword: viewModel.keywordText
                    )
                }
            }
        }
        .background(Dodam.color(.background))
        .task {
            await viewModel.onAppear()
        }
        .alert(
            viewModel.dialogMessage,
            isPresented: $viewModel.showDialog
        ) {
            Button("확인", role: .none) {}
        }
    }
}

#Preview {
    WakeupSongApplyView()
}
