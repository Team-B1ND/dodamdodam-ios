//
//  OutSleepingCell.swift
//  DodamDodam
//
//  Created by 이민규 on 4/3/24.
//

import SwiftUI
import DDS

struct OutSleepingCell: View {
    
    private let outSleepingData: OutSleepingResponse
    
    init(
        data outSleepingData: OutSleepingResponse
    ) {
        self.outSleepingData = outSleepingData
    }
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 12) {
                ZStack {
                    Text({ () -> String in
                        switch outSleepingData.status {
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
                    switch outSleepingData.status {
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
                Text(outSleepingData.createdAt.parseString(format: "M월 d일 (E)"))
                    .font(.label(.large))
                    .dodamColor(.onSurfaceVariant)
                    .padding(.top, 5)
            }
            .padding([.top, .horizontal], 16)
            VStack(spacing: 12) {
                Text("\(outSleepingData.reason)")
                    .font(.body(.medium))
                    .dodamColor(.onSurface)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Rectangle()
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(Dodam.color(.secondary))
                if outSleepingData.status == .rejected {
                    HStack(spacing: 8) {
                        Text("거절 사유")
                            .font(.label(.large))
                            .dodamColor(.onSurfaceVariant)
                        Text("\(outSleepingData.rejectReason ?? "선생님께서 외박 신청을 거절하였습니다.")")
                            .font(.system(size: 16, weight: .medium))
                            .dodamColor(.onSurface)
                        Spacer()
                    }
                    .padding(.top, 4)
                } else {
                    HStack(alignment: .bottom, spacing: 16) {
                        VStack(spacing: 8) {
                            HStack(alignment: .bottom, spacing: 4) {
                                Text(outSleepingData.startAt.parseString(format: "M월 d일"))
                                    .font(.body(.medium))
                                    .dodamColor(.onSurface)
                                Text("외박")
                                    .font(.label(.large))
                                    .dodamColor(.onSurfaceVariant)
                                Spacer()
                                Text(outSleepingData.endAt.parseString(format: "M월 d일"))
                                    .font(.body(.medium))
                                    .dodamColor(.onSurface)
                                Text("복귀")
                                    .font(.label(.large))
                                    .dodamColor(.onSurfaceVariant)
                            }
                            DodamLinearProgressView(
                                progress: calculatingDateProgress(
                                    startAt: outSleepingData.startAt,
                                    endAt: outSleepingData.endAt,
                                    dateFormat: "yyyy-MM-dd"
                                ),
                                isDisabled: outSleepingData.status == .pending ? true : false
                            )
                        }
                    }
                }
            }
            .padding([.bottom, .horizontal], 16)
        }
        .background(Dodam.color(.surfaceContainer))
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}
