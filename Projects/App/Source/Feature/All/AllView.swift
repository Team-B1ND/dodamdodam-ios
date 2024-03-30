//
//  AllView.swift
//  DodamDodam
//
//  Created by 이민규 on 3/29/24.
//

import SwiftUI
import DDS

struct AllView: View {
    
    @InjectObject var viewModel: AllViewModel
    @Flow var flow
    
    var body: some View {
        DodamScrollView {
            HStack {
                Text("전체")
                    .font(.headline(.small))
                    .dodamColor(.onSurface)
                    .padding(.leading, 20)
                Spacer()
                Button {
                    flow.push(NightStudyApplyView())
                } label: {
                    Dodam.icon(.gear)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .dodamColor(.onSurfaceVariant)
                }
                .frame(width: 44, height: 44)
                .padding(.trailing, 12)
            }
            .frame(height: 58)
            .frame(maxWidth: .infinity)
            .background(.regularMaterial)
        } content: {
            VStack(spacing: 24) {
                HStack(spacing: 16) {
                    if let image = viewModel.memberData?.profileImage {
                        AsyncImage(url: URL(string: image)) { image in
                            image
                                .resizable()
                                .frame(width: 70, height: 70)
                        } placeholder: {
                            Rectangle()
                                .frame(width: 70, height: 70)
                                .shimmer()
                        }
                    } else {
                        Rectangle()
                            .frame(width: 70, height: 70)
                            .shimmer()
                    }
                }
            }
        }
        .background(Dodam.color(.background))
        .task {
            await viewModel.getTestData()
        }
    }
}

#Preview {
    AllView()
}
