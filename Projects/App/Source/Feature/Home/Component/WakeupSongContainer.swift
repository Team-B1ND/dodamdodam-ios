//
//  WakeupSongContainer.swift
//  DodamDodam
//
//  Created by 이민규 on 3/17/24.
//

import SwiftUI
import DDS

struct WakeupSongContainer: View {

    private let wakeupSongData: [WakeupSong]?
    
    public init(
        data wakeupSongData: [WakeupSong]?
    ) {
        self.wakeupSongData = wakeupSongData
    }
    
    var body: some View {
        if let data = wakeupSongData {
            DodamPageView {
                ForEach(data, id: \.self) { data in
                    HStack(alignment: .top, spacing: 12) {
                        Link(destination: URL(string: data.videoUrl) ?? URL(string: "about:blank")!) {
                            AsyncImage(url: URL(string: data.thumbnailUrl)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 120, height: 67)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                            } placeholder: {
                                Rectangle()
                                    .frame(width: 120, height: 67)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                    .shimmer()
                            }
                            
                        }
                        /// marquee 적용 하기
                        VStack(alignment: .leading, spacing: 0) {
                            Text("\(data.videoTitle)")
                                .font(.body(.medium))
                                .dodamColor(.onSurface)
                                .lineLimit(1)
                            Text("\(data.channelTitle)")
                                .font(.label(.large))
                                .dodamColor(.onSurfaceVariant)
                                .lineLimit(1)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .page()
                }
            }
            .frame(height: 80)
        } else {
            SupportingContainer(
                subTitle: "승인된 기상송이 없어요",
                title: "기상송 신청하기"
            )
        }
    }
}

#Preview {
    let dummy1 = WakeupSong(
        id: 73,
        thumbnailUrl: "https://i.ytimg.com/vi/7jxlsVRylq8/sddefault.jpg",
        videoTitle: "Flowering (개화 (Flowering))",
        videoId: "7jxlsVRylq8",
        videoUrl: "https://music.youtube.com/watch?v=7jxlsVRylq8&si=JUNLf--vr2hvWFH2",
        channelTitle: "LUCY - Topic",
        status: "ALLOWED",
        createdAt: "test-te-st"
    )
    let dummy2 = WakeupSong(
        id: 74,
        thumbnailUrl: "https://i.ytimg.com/vi/GAy1NSzjxYY/sddefault.jpg",
        videoTitle: "LE SSERAFIM 'EASY' Lyrics (르세라핌 EASY 가사)",
        videoId: "GAy1NSzjxYY",
        videoUrl: "https://www.youtube.com/watch?v=GAy1NSzjxYY",
        channelTitle: "LE SSERAFIM",
        status: "ALLOWED",
        createdAt: "test-te-st"
    )
    return VStack(spacing: 12) {
        DodamContainer.default(
            title: "오늘의 기상송",
            icon: Dodam.icon(.note)
        ) {
            WakeupSongContainer(data: [dummy1, dummy2])
                .padding(6)
        }
        DodamContainer.default(
            title: "오늘의 기상송",
            icon: Dodam.icon(.note)
        ) {
            WakeupSongContainer(data: nil)
                .padding(6)
        }
    }
    .padding(16)
    .background(Dodam.color(.surface))
}
