//
//  BannerContainer.swift
//  DodamDodam
//
//  Created by 이민규 on 3/18/24.
//

import SwiftUI
import DDS

struct BannerContainer: View {
    
    private let bannerData: [Banner]?
    
    public init(
        data bannerData: [Banner]?
    ) {
        self.bannerData = bannerData
    }
    
    var body: some View {
        if let data = bannerData {
            TabView {
                ForEach(data, id: \.self) { data in
                    Link(destination: URL(string: data.redirectUrl) ?? URL(string: "about:blank")!) {
                        AsyncImage(url: URL(string: data.imageUrl)) { image in
                            image
                                .resizable()
                        } placeholder: {
                            Rectangle()
                                .opacity(0.5)
                        }
                    }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .aspectRatio(80/12, contentMode: .fill)
            .frame(maxWidth: .infinity)
            .clipShape(RoundedRectangle(cornerRadius: 18))
        }
    }
}

#Preview {
    let dummy = Banner(
        id: 1,
        expireA: "2024-03-17 00:00:00",
        imageUrl: "https://zrr.kr/lzRi",
        redirectUrl: "https://ahead-yacht-97a.notion.site/9-9ee5631337b049e8b1b57ba9227b52ab?pvs=4",
        title: "dodam",
        status: "Active"
    )
    return ScrollView {
        VStack(spacing: 12) {
            BannerContainer(data: [dummy])
        }
        .padding(16)
    }
    .background(Dodam.color(.surface))
}

public struct Banner: Codable, Hashable {
    let id: Int
    let expireA, imageUrl, redirectUrl, title: String
    let status: String
}
