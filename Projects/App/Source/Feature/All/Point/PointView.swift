//
//  PointView.swift
//  DodamDodam
//
//  Created by 이민규 on 4/3/24.
//

import SwiftUI
import DDS

struct PointView: View {
    
    @InjectObject var viewModel: PointViewModel
    @Flow var flow
    
    var body: some View {
        DodamScrollView.medium(title: "내 상벌점") {
            VStack(spacing: 24) {
                Text("상벌점 발급 내역이 없어요.")
                    .font(.body(.medium))
                    .dodamColor(.tertiary)
                    .padding(.top, 24)
            }
            .padding(.horizontal, 16)
        }
        .subView {
            VStack(spacing: 24) {
                SegmentedView(
                    labels: ["기숙사", "학교"],
                    selection: $viewModel.selection
                )
                HStack(spacing: 32) {
                    if let data = viewModel.domitoryPointScoreData,
                       viewModel.selection == 0 {
                        VStack(spacing: 0) {
                            Text("상점")
                                .font(.body(.medium))
                                .dodamColor(.tertiary)
                            Text("\(data.bonus)점")
                                .font(.headline(.large))
                                .dodamColor(.error)
                        }
                        VStack(spacing: 0) {
                            Text("벌점")
                                .font(.body(.medium))
                                .dodamColor(.tertiary)
                            Text("\(data.minus)점")
                                .font(.headline(.large))
                                .dodamColor(.primary)
                        }
                    } else if let data = viewModel.schoolPointScoreData {
                        VStack(spacing: 0) {
                            Text("상점")
                                .font(.body(.medium))
                                .dodamColor(.tertiary)
                            Text("\(data.bonus)점")
                                .font(.headline(.large))
                                .dodamColor(.error)
                        }
                        VStack(spacing: 0) {
                            Text("벌점")
                                .font(.body(.medium))
                                .dodamColor(.tertiary)
                            Text("\(data.minus)점")
                                .font(.headline(.large))
                                .dodamColor(.primary)
                        }
                    }
                }
                .padding(.top, 24)
                Text("상벌점 발급 내역")
                    .font(.title(.medium))
                    .dodamColor(.onBackground)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 24)
            }
        }
        .bottomMask()
        .task {
            await viewModel.onAppear()
        }
    }
}

#Preview {
    FlowPreview {
        PointView()
    }
}