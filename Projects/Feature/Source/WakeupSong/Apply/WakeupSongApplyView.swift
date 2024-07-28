//
//  WakeupSongApplyView.swift
//  DodamDodam
//
//  Created by dgsw8th71 on 4/1/24.
//

import SwiftUI
import DDS
import CachedAsyncImage
import FlowKit
import Shared

struct WakeupSongApplyView: View {
    
    @DodamDialog private var dialog
    @StateObject var viewModel = WakeupSongApplyViewModel()
    @Flow var flow
    
    var body: some View {
        DodamScrollView.medium(title: "기상송을\n검색해주세요") {
            VStack(alignment: .leading, spacing: 0) {
                if let data = viewModel.wakeupSongSearchData,
                   !viewModel.isSearchLoading {
                    LazyVStack(spacing: 4) {
                        ForEach(data, id: \.self) { data in
                            Button {
                                viewModel.dialogMessage = "\(data.videoTitle)"
                                viewModel.videoUrl = data.videoUrl
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
                                    .clipShape(.small)
                                    .padding(.vertical, 8)
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text("\(data.videoTitle)")
                                            .body1(.bold)
                                            .foreground(DodamColor.Label.normal)
                                            .lineLimit(1)
                                        Text("\(data.channelTitle)")
                                            .caption1(.medium)
                                            .foreground(DodamColor.Label.alternative)
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
                        .headline(.bold)
                        .foreground(DodamColor.Label.normal)
                    Text("요즘 인기있는 노래를 바로 신청해보세요")
                        .label(.medium)
                        .foreground(DodamColor.Label.normal)
                }
                .padding(.top, 20)
                LazyVStack(spacing: 4) {
                    if let data = viewModel.wakeupSongChartData {
                        ForEach(data, id: \.self) { data in
                            Button {
                                viewModel.dialogMessage = "\(data.artist)-\(data.name)"
                                viewModel.artist = data.artist
                                viewModel.title = data.name
                            } label: {
                                HStack(spacing: 16) {
                                    Text("\(data.rank)")
                                        .label(.bold)
                                        .foreground(DodamColor.Primary.normal)
                                        .frame(width: 25, height: 20)
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
                                            .body1(.bold)
                                            .foreground(DodamColor.Label.normal)
                                            .lineLimit(1)
                                        Text("\(data.artist)")
                                            .caption1(.medium)
                                            .foreground(DodamColor.Label.alternative)
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
        .background(DodamColor.Background.normal)
        .task {
            await viewModel.onAppear()
        }
        .onChange(of: viewModel.showDialog) { _ in
            defer {
                viewModel.showDialog = false
            }
            let dialog = Dialog(title: "기상송을 신청하시겠습니까")
                .message(viewModel.dialogMessage)
                .primaryButton("신청") {
                    Task {
                        await viewModel.postWakeupSong()
                        viewModel.clearData()
                    }
                    flow.pop()
                }
                .secondaryButton("취소")
            self.dialog.present(dialog)
        }
        .onChange(of: viewModel.dialogErrorMessage) {
            let dialog = Dialog(title: $0)
                .primaryButton("확인") {
                    viewModel.clearData()
                }
            self.dialog.present(dialog)
        }
    }
}

#Preview {
    WakeupSongApplyView()
}
