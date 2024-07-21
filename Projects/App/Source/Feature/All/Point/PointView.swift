//
//  PointView.swift
//  DodamDodam
//
//  Created by 이민규 on 4/3/24.
//

import SwiftUI
import DDS

struct PointView: View {
    
    @StateObject var viewModel = PointViewModel()
    @Flow var flow
    
    var body: some View {
        DodamScrollView.medium(title: "내 상벌점") {
            VStack(spacing: 12) {
                if let data = viewModel.pointData,
                   !data.isEmpty {
                    ForEach(data, id: \.self) { data in
                        PointCell(point: data)
                    }
                } else if viewModel.pointData == nil {
                    DodamLoadingView()
                } else {
                    Text("상벌점 발급 내역이 없어요.")
                        .font(.body(.medium))
                        .dodamColor(.tertiary)
                        .padding(.top, 24)
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 150)
        }
        .subView {
            VStack(spacing: 24) {
                SegmentedView(
                    labels: ["기숙사", "학교"],
                    selection: $viewModel.selection
                )
                HStack(spacing: 32) {
                    VStack(spacing: 0) {
                        Text("상점")
                            .font(.body(.medium))
                            .dodamColor(.tertiary)
                        if let bonus = viewModel.bocus {
                            Text("\(bonus)점")
                                .font(.headline(.large))
                                .dodamColor(.primary)
                        } else {
                            DodamLoadingView()
                                .frame(height: 44)
                        }
                    }
                    VStack(spacing: 0) {
                        Text("벌점")
                            .font(.body(.medium))
                            .dodamColor(.tertiary)
                        if let minus = viewModel.minus {
                            Text("\(minus)점")
                                .font(.headline(.large))
                                .dodamColor(.error)
                        } else {
                            DodamLoadingView()
                                .frame(height: 44)
                        }
                    }
                }
                .padding(.top, 24)
                .frame(height: 85)
                Text("상벌점 발급 내역")
                    .font(.title(.medium))
                    .dodamColor(.onBackground)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 24)
            }
        }
        .task {
            await viewModel.onAppear()
        }
        .refreshable {
            await viewModel.onRefresh()
        }
    }
}

#Preview {
    FlowPreview {
        PointView()
    }
}
