//
//  OutSleepingCell.swift
//  DodamDodam
//
//  Created by 이민규 on 4/3/24.
//

import SwiftUI
import DDS
import Domain
import Shared

struct OutSleepingCell: View {
    
    private let outSleepingData: OutSleepingResponse
    private let removeAction: () -> Void
    
    init(
        data outSleepingData: OutSleepingResponse,
        removeAction: @escaping () -> Void
    ) {
        self.outSleepingData = outSleepingData
        self.removeAction = removeAction
    }
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                DodamTag({
                    switch outSleepingData.status {
                    case .allowed: "승인됨"
                    case .pending: "대기중"
                    case .rejected: "거절됨"
                    }
                }(), type: {
                    switch outSleepingData.status {
                    case .allowed: .primary
                    case .pending: .secondary
                    case .rejected: .negative
                    }
                }())
                Spacer()
                Button {
                    removeAction()
                } label: {
                    Image("Trash")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foreground(DodamColor.Line.normal)
                }
                .scaledButtonStyle()
            }
            Text("\(outSleepingData.reason)")
                .body1(.medium)
                .foreground(DodamColor.Label.normal)
                .frame(maxWidth: .infinity, alignment: .leading)
            DodamDivider()
            HStack(alignment: .bottom, spacing: 4) {
                Text(outSleepingData.endAt.remainingTimeText)
                    .heading2(.bold)
                    .foreground(DodamColor.Label.normal)
                Text("남음")
                    .label(.medium)
                    .foreground(DodamColor.Label.alternative)
                Spacer()
            }
                if outSleepingData.status == .rejected {
                    HStack(spacing: 8) {
                        Text("거절 사유")
                            .label(.medium)
                            .foreground(DodamColor.Label.alternative)
                        Text("\(outSleepingData.rejectReason ?? "선생님께서 외박 신청을 거절하였습니다.")")
                            .body1(.medium)
                            .font(.system(size: 16, weight: .medium))
                            .foreground(DodamColor.Label.normal)
                        Spacer()
                    }
                } else {
                    VStack(spacing: 4) {
                        DodamLinearProgressView(
                            progress: calculatingDateProgress(
                                startAt: outSleepingData.startAt,
                                endAt: outSleepingData.endAt,
                                dateFormat: "yyyy-MM-dd"
                            ),
                            isDisabled: outSleepingData.status == .pending
                        )
                        HStack(spacing: 4) {
                            Text("외박")
                                .label(.medium)
                                .foreground(DodamColor.Label.alternative)
                            Text(outSleepingData.startAt.parseString(format: "M월 d일"))
                                .body1(.medium)
                                .foreground(DodamColor.Label.neutral)
                            Spacer()
                            Text("복귀")
                                .label(.medium)
                                .foreground(DodamColor.Label.alternative)
                            Text(outSleepingData.endAt.parseString(format: "M월 d일"))
                                .body1(.medium)
                                .foreground(DodamColor.Label.neutral)
                    }
                }
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 16)
        .background(DodamColor.Background.normal)
        .clipShape(.large)
    }
}
