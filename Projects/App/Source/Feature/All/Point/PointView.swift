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
                if let data = viewModel.domitoryPointData,
                   viewModel.selection == 0,
                   !data.isEmpty {
                    ForEach(data, id: \.self) { data in
                        HStack {
                            VStack(alignment: .leading, spacing: 0) {
                                Text("\(data.reason.reason)")
                                    .font(.body(.large))
                                    .dodamColor(.onBackground)
                                Text("\(data.teacher.position) • \(data.issueAt)")
                                    .font(.label(.large))
                                    .dodamColor(.onSurfaceVariant)
                            }
                            .padding(.leading, 8)
                            Spacer()
                            Text("\(data.reason.score)")
                                .font(.body(.large))
                                .dodamColor(data.reason.scoreType == .minus
                                            ? .error
                                            : .primary
                                )
                                .padding(.trailing, 8)
                        }
                        .padding(.vertical, 8)
                    }
                } else if let data = viewModel.schoolPointData,
                          !data.isEmpty {
                    ForEach(data, id: \.self) { data in
                        HStack {
                            VStack(alignment: .leading, spacing: 0) {
                                Text("\(data.reason.reason)")
                                    .font(.body(.large))
                                    .dodamColor(.onBackground)
                                Text("\(data.teacher.position) • \(data.issueAt)")
                                    .font(.label(.large))
                                    .dodamColor(.onSurfaceVariant)
                            }
                            .padding(.leading, 8)
                            Spacer()
                            Text("\(data.reason.score)")
                                .font(.body(.large))
                                .dodamColor(
                                    data.reason.scoreType == .minus
                                    ? .error
                                    : .primary
                                )
                                .padding(.trailing, 8)
                        }
                        .padding(.vertical, 8)
                    }
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
                        Text("\(viewModel.bonus[viewModel.selection])점")
                            .font(.headline(.large))
                            .dodamColor(.primary)
                    }
                    VStack(spacing: 0) {
                        Text("벌점")
                            .font(.body(.medium))
                            .dodamColor(.tertiary)
                        Text("\(viewModel.minus[viewModel.selection])점")
                            .font(.headline(.large))
                            .dodamColor(.error)
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
