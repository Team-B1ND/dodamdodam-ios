//
//  NightStudyApplyCell.swift
//  DodamDodam
//
//  Created by 이민규 on 3/29/24.
//

import SwiftUI
import DDS
import Combine

struct NightStudyApplyCell: View {
    
    private let nightStudyData: NightStudyResponse
    
    public init(
        data nightStudyData: NightStudyResponse
    ) {
        self.nightStudyData = nightStudyData
    }
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 12) {
                ZStack {
                    Text({ () -> String in
                        switch nightStudyData.status {
                        case .allowed: 
                            return "승인됨"
                        case .pending: 
                            return "대기중"
                        case .rejected:
                            return "거절됨"
                        }
                    }())
                    .font(.title(.small))
                    .dodamColor(.onPrimary)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 12)
                }
                .frame(height: 27)
                .background({ () -> Color in
                    switch nightStudyData.status {
                    case .allowed: 
                        return Dodam.color(.primary)
                    case .pending: 
                        return Dodam.color(.onSurfaceVariant)
                    case .rejected:
                        return Dodam.color(.error)
                    }
                }())
                .clipShape(RoundedRectangle(cornerRadius: 32))
                Spacer()
                Text({
                    let date = nightStudyData.createdAt.parseString(format: "M월 d일 (E)")
                    return date
                }())
                .font(.label(.large))
                .dodamColor(.onSurfaceVariant)
                .padding(.top, 5)
            }
            .padding([.top, .horizontal], 16)
            VStack(spacing: 12) {
                Text("\(nightStudyData.content)")
                    .font(.body(.medium))
                    .dodamColor(.onSurface)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Rectangle()
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(Dodam.color(.secondary))
                if nightStudyData.status == .rejected {
                    HStack(spacing: 8) {
                        Text("거절 사유")
                            .font(.label(.large))
                            .dodamColor(.onSurfaceVariant)
                        Text("\(nightStudyData.rejectReason ?? "선생님께서 심야 자습 신청을 거절하였습니다")")
                            .font(.system(size: 16, weight: .medium))
                            .dodamColor(.onSurface)
                        Spacer()
                    }
                    .padding(.top, 4)
                } else {
                    HStack(alignment: .bottom, spacing: 16) {
                        VStack(spacing: 8) {
                            HStack(alignment: .bottom, spacing: 4) {
                                Text(nightStudyData.startAt.parseString(format: "M월 d일"))
                                    .font(.body(.medium))
                                    .dodamColor(.onSurface)
                                Text("시작")
                                    .font(.label(.large))
                                    .dodamColor(.onSurfaceVariant)
                                Spacer()
                                Text(nightStudyData.endAt.parseString(format: "M월 d일"))
                                    .font(.body(.medium))
                                    .dodamColor(.onSurface)
                                Text("종료")
                                    .font(.label(.large))
                                    .dodamColor(.onSurfaceVariant)
                            }
                            DodamLinearProgressView(
                                progress: calculatingDateProgress(
                                    startAt: nightStudyData.startAt,
                                    endAt: nightStudyData.endAt,
                                    dateFormat: "yyyy-MM-dd"
                                ),
                                isDisabled: nightStudyData.status == .pending ? true : false
                            )
                        }
                    }
                    if let reasonForPhone = nightStudyData.reasonForPhone,
                       nightStudyData.doNeedPhone {
                        HStack(spacing: 8) {
                            Text("휴대폰 사유")
                                .font(.label(.large))
                                .dodamColor(.onSurfaceVariant)
                            Text("\(reasonForPhone)")
                                .font(.system(size: 16, weight: .medium))
                                .dodamColor(.onSurface)
                            Spacer()
                        }
                        .padding(.top, 4)
                    }
                }
            }
            .padding([.bottom, .horizontal], 16)
        }
        .background(Dodam.color(.surfaceContainer))
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}
