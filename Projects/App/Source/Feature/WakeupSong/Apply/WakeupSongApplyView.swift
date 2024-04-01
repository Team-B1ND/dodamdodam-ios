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
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 16) {
                    DodamTextField.default(
                        title: "제목, 아티스트 혹은 링크",
                        text: $viewModel.keywordText
                    )
                    Button {
                        print("search")
                    } label: {
                        Text("검색")
                            .font(.body(.medium))
                            .dodamColor(.onSecondaryContainer)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 8)
                            .background(Color.dodam(.secondaryContainer))
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text("이런 노래는 어떤가요?")
                        .font(.title(.medium))
                        .dodamColor(.onSurface)
                    Text("요즘 인기있는 노래를 추천해드릴게요")
                        .font(.body(.small))
                        .dodamColor(.onSurface)
                }
                .padding(.top, 40)
    
                LazyVStack(spacing: 4) {
                    if let data = viewModel.wakeupSongChartData {
                        ForEach(data, id: \.self) { data in
                            HStack(spacing: 16) {
                                Text("\(data.rank)위")
                                    .font(.label(.large))
                                    .dodamColor(.onBackground)
                                CachedAsyncImage(url: URL(string: data.thumbnail)) {
                                    $0
                                        .resizable()
                                        .frame(width: 67, height: 67)
                                } placeholder: {
                                    Rectangle()
                                        .frame(width: 67, height: 67)
                                        .shimmer()
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 8))
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
                    }
                }
                .padding(.top, 12)
                .padding(.bottom, 150)
            }
            .padding(.horizontal, 16)
        }
        .navigationBarHidden(false)
        .task {
            await viewModel.onAppear()
        }
    }
}

#Preview {
    WakeupSongApplyView()
}
