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
                    .body(.bold)
                    .foreground(DodamColor.Static.white)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 12)
                }
                .frame(height: 27)
                .background {
                    Group {
                        let color: DodamColorable = switch outGoingData.status {
                        case .allowed:
                            DodamColor.Primary.normal
                        case .pending:
                            DodamColor.Line.normal
                        case .rejected:
                            DodamColor.Status.negative
                        }
                        Dodam.color(color)
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 32))
                Spacer()
                Text(outGoingData.startAt.parseString(format: "M월 d일 (E)"))
//                    .font(.label(.large))
//                    .dodamColor(.onSurfaceVariant)
//                    .padding(.top, 5)
            }
            .padding([.top, .horizontal], 16)
            VStack(spacing: 12) {
                Text("\(outGoingData.reason)")
//                    .font(.body(.medium))
//                    .dodamColor(.onSurface)
//                    .frame(maxWidth: .infinity, alignment: .leading)
                Rectangle()
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
//                    .foregroundStyle(Dodam.color(.secondary))
                if outGoingData.status == .rejected {
                    HStack(spacing: 8) {
                        Text("거절 사유")
//                            .font(.label(.large))
//                            .dodamColor(.onSurfaceVariant)
                        Text("\(outGoingData.rejectReason ?? "선생님께서 외출 신청을 거절하였습니다.")")
                            .font(.system(size: 16, weight: .medium))
//                            .dodamColor(.onSurface)
                        Spacer()
                    }
                    .padding(.top, 4)
                } else {
                    HStack(alignment: .bottom, spacing: 16) {
                        VStack(spacing: 8) {
                            HStack(alignment: .bottom, spacing: 4) {
                                Text(outGoingData.startAt.parseString(format: "H시 m분"))
                                    .font(.body(.medium))
//                                    .dodamColor(.onSurface)
                                Text("외출")
//                                    .font(.label(.large))
//                                    .dodamColor(.onSurfaceVariant)
                                Spacer()
                                Text(outGoingData.endAt.parseString(format: "H시 m분"))
//                                    .font(.body(.medium))
//                                    .dodamColor(.onSurface)
                                Text("복귀")
//                                    .font(.label(.large))
//                                    .dodamColor(.onSurfaceVariant)
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
//        .background(Dodam.color(.surfaceContainer))
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}
