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
                        switch outSleepingData.status.rawValue {
                        case "ALLOWED": return "승인됨"
                        case "PENDING": return "대기중"
                        case "DENIED": return "거절됨"
                        default: return ""
                        }
                    }())
                    .font(.title(.small))
                    .dodamColor(.onPrimary)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 12)
                }
                .frame(height: 27)
                .background({ () -> Color in
                    switch outSleepingData.status.rawValue {
                    case "ALLOWED": return Dodam.color(.primary)
                    case "PENDING": return Dodam.color(.onSurfaceVariant)
                    case "DENIED": return Dodam.color(.error)
                    default: return Dodam.color(.primary)
                    }
                }())
                .clipShape(RoundedRectangle(cornerRadius: 32))
                Spacer()
                Text({ () -> String in
                    if let date = outSleepingData.createdAt.parseDate(
                        format: "yyyy-MM-dd HH:mm:ss"
                    ) {
                        return date.parseString(format: "M월 d일 (E)")
                    }
                    return "오류"
                }())
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
                if outSleepingData.status.rawValue == "DENIED" {
                    HStack(spacing: 8) {
                        Text("거절 사유")
                            .font(.label(.large))
                            .dodamColor(.onSurfaceVariant)
                        // 나중에 거절 사유 추가되면 데이터 넣기
                        Text("선생님께서 외출을 거절하였습니다")
                            .font(.system(size: 16, weight: .medium))
                            .dodamColor(.onSurface)
                        Spacer()
                    }
                    .padding(.top, 4)
                } else {
                    HStack(alignment: .bottom, spacing: 16) {
                        VStack(spacing: 8) {
                            HStack(alignment: .bottom, spacing: 4) {
                                Text({ () -> String in
                                    if let date = outSleepingData.startAt.parseDate(
                                        format: "yyyy-MM-dd HH:mm:ss"
                                    ) {
                                        return date.parseString(format: "M월 d일")
                                    }
                                    return "오류"
                                }())
                                .font(.body(.medium))
                                .dodamColor(.onSurface)
                                Text("외박")
                                    .font(.label(.large))
                                    .dodamColor(.onSurfaceVariant)
                                Spacer()
                                Text({ () -> String in
                                    if let date = outSleepingData.startAt.parseDate(
                                        format: "yyyy-MM-dd HH:mm:ss"
                                    ) {
                                        return date.parseString(format: "M월 d일")
                                    }
                                    return "오류"
                                }())
                                .font(.body(.medium))
                                .dodamColor(.onSurface)
                                Text("복귀")
                                    .font(.label(.large))
                                    .dodamColor(.onSurfaceVariant)
                            }
                            DodamLinearProgressView(
                                progress: calculatingDateProgress(
                                    outSleepingData.startAt,
                                    outSleepingData.endAt
                                ),
                                isDisabled: outSleepingData.status.rawValue == "PENDING" ? true : false
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
