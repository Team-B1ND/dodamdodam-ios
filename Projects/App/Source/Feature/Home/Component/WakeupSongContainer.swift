//
//  WakeupSongContainer.swift
//  DodamDodam
//
//  Created by 이민규 on 3/17/24.
//

import SwiftUI

struct WakeupSongContainer: View {
    
    let data: WakeupSong?
    
    init(
        data: WakeupSong?
    ) {
        self.data = data
    }
    
    var body: some View {
        if let data = data {
            HStack(alignment: .top, spacing: 12) {
                Link(destination: URL(string: data.videoUrl) ?? URL(string: "about:blank")!) {
                    AsyncImage(url: URL(string: data.thumbnailUrl)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 160/1.2, height: 90/1.2)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    } placeholder: {
                        Rectangle()
                            .frame(width: 160/1.2, height: 90/1.2)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(data.videoTitle)")
                        .font(.dodamBody2)
                        .foregroundStyle(Color(.onSurfaceVariant))
                    Text("\(data.channelTitle)")
                        .font(.dodamLabel2)
                        .foregroundStyle(Color(.tertiary))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
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
    return VStack(spacing: 12) {
        DodamContainer.default(
            title: "오늘의 기상송",
            icon: Image(.note)
        ) {
            Button {
                // action
            } label: {
                WakeupSongContainer(data: dummy1)
            }
        }
        .arrowButtonAction {
            print("화살표 액션")
        }
        DodamContainer.default(
            title: "오늘의 기상송",
            icon: Image(.note)
        ) {
            Button {
                // action
            } label: {
                WakeupSongContainer(data: nil)
            }
        }
        .arrowButtonAction {
            print("화살표 액션")
        }
    }
    .padding(16)
    .background(Color(.surface))
}

struct WakeupSong: Codable, Hashable {
    let id: Int
    let thumbnailUrl: String
    let videoTitle: String
    let videoId: String
    let videoUrl: String
    let channelTitle: String
    let status: String
    let createdAt: String
}
