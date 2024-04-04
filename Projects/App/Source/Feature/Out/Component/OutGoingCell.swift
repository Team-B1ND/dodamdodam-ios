//
//  OutGoingCell.swift
//  DodamDodam
//
//  Created by 이민규 on 3/23/24.
//

import SwiftUI
import DDS

struct OutGoingCell: View {
    
    private let outGoingData: OutGoingResponse
    
    init(
        data outGoingData: OutGoingResponse
    ) {
        self.outGoingData = outGoingData
    }
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 12) {
                ZStack {
                    Text({ () -> String in
                        switch outGoingData.status {
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
                    switch outGoingData.status {
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
                Text({ () -> String in
                    guard let date = outGoingData.createdAt.parseDate(
                        format: "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
                    ) else {
                        return "시간 오류"
                    }
                    return date.parseString(format: "M월 d일 (E)")
                }())
                .font(.label(.large))
                .dodamColor(.onSurfaceVariant)
                .padding(.top, 5)
            }
            .padding([.top, .horizontal], 16)
            VStack(spacing: 12) {
                Text("\(outGoingData.reason)")
                    .font(.body(.medium))
                    .dodamColor(.onSurface)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Rectangle()
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(Dodam.color(.secondary))
                if outGoingData.status == .rejected {
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
                                    if let date = outGoingData.startAt.parseDate(
                                        format: "yyyy-MM-dd'T'HH:mm:ss"
                                    ) {
                                        return date.parseString(format: "H시 m분")
                                    }
                                    return "시간 오류"
                                }())
                                .font(.body(.medium))
                                .dodamColor(.onSurface)
                                Text("외출")
                                    .font(.label(.large))
                                    .dodamColor(.onSurfaceVariant)
                                Spacer()
                                Text({ () -> String in
                                    if let date = outGoingData.endAt.parseDate(
                                        format: "yyyy-MM-dd'T'HH:mm:ss"
                                    ) {
                                        return date.parseString(format: "H시 m분")
                                    }
                                    return "시간 오류"
                                }())
                                .font(.body(.medium))
                                .dodamColor(.onSurface)
                                Text("복귀")
                                    .font(.label(.large))
                                    .dodamColor(.onSurfaceVariant)
                            }
                            DodamLinearProgressView(
                                progress: calculatingDateProgress(
                                    startAt: outGoingData.startAt,
                                    endAt: outGoingData.endAt,
                                    dateFormat: "yyyy-MM-dd'T'HH:mm:ss"
                                ),
                                isDisabled: outGoingData.status == .pending ? true : false
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
