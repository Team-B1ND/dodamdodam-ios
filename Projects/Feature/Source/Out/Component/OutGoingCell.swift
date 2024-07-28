//
//  OutGoingCell.swift
//  DodamDodam
//
//  Created by 이민규 on 3/23/24.
//

import SwiftUI
import DDS
import Domain
import DIContainer
import Shared

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
                DodamTag({
                    switch outGoingData.status {
                    case .allowed: "승인됨"
                    case .pending: "대기중"
                    case .rejected: "거절됨"
                    }
                }(), type: {
                    switch outGoingData.status {
                    case .allowed: .primary
                    case .pending: .secondary
                    case .rejected: .negative
                    }
                }())
                Spacer()
                Text({
                    let date = outGoingData.createdAt.parseString(format: "M월 d일 (E)")
                    return date
                }())
                .label(.medium)
                .foreground(DodamColor.Label.normal)
                .padding(.top, 5)
            }
            .padding([.top, .horizontal], 16)
            VStack(spacing: 12) {
                Text("\(outGoingData.reason)")
                    .body1(.medium)
                    .foreground(DodamColor.Label.normal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                DodamDivider()
                if outGoingData.status == .rejected {
                    HStack(spacing: 8) {
                        Text("거절 사유")
                            .label(.regular)
                            .foreground(DodamColor.Label.alternative)
                        Text("\(outGoingData.rejectReason ?? "선생님께서 외출 신청을 거절하였습니다.")")
                            .font(.system(size: 16, weight: .medium))
                            .foreground(DodamColor.Label.normal)
                        Spacer()
                    }
                    .padding(.top, 4)
                } else {
                    HStack(alignment: .bottom, spacing: 16) {
                        VStack(spacing: 8) {
                            HStack(alignment: .bottom, spacing: 4) {
                                Text("외출")
                                    .label(.medium)
                                    .foreground(DodamColor.Label.alternative)
                                Text(outGoingData.startAt.parseString(format: "H시 m분"))
                                    .body1(.medium)
                                    .foreground(DodamColor.Label.neutral)
                                Spacer()
                                Text("복귀")
                                    .label(.medium)
                                    .foreground(DodamColor.Label.alternative)
                                Text(outGoingData.endAt.parseString(format: "H시 m분"))
                                    .body1(.medium)
                                    .foreground(DodamColor.Label.neutral)
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
        .background(DodamColor.Background.normal)
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}
