//
//  WakeupSongApplyView.swift
//  DodamDodam
//
//  Created by dgsw8th71 on 4/1/24.
//

import SwiftUI
import DDS

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
                Text("이런 노래는 어떤가요?")
                    .font(.title(.medium))
                    .dodamColor(.onSurface)
                    .padding(.top, 40)
                Text("요즘 인기있는 노래를 추천해드릴게요")
                    .font(.body(.small))
                    .dodamColor(.onSurface)
                    .padding(.top, 2)
//                LazyVStack(spacing: 4) {
//                    ForEach(songList, id: \.self) { _ in
//                        WakeupSongCell(
//                            data: data
//                        )
//                    }
//                }
//                .padding(.top, 12)
            }
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    WakeupSongApplyView()
}
