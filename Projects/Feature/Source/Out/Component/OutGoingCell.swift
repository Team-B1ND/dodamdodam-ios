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
    private let removeAction: () -> Void
    
    init(
        data outGoingData: OutGoingResponse,
        removeAction: @escaping () -> Void
    ) {
        self.outGoingData = outGoingData
        self.removeAction = removeAction
    }
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
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
            Text("\(outGoingData.reason)")
                .body1(.medium)
                .foreground(DodamColor.Label.normal)
                .frame(maxWidth: .infinity, alignment: .leading)
            DodamDivider()
            HStack(alignment: .bottom, spacing: 4) {
                Text(outGoingData.endAt.remainingTimeText)
                    .heading2(.bold)
                    .foreground(DodamColor.Label.normal)
                Text("남음")
                    .label(.medium)
                    .foreground(DodamColor.Label.alternative)
                Spacer()
            }
            if outGoingData.status == .rejected {
                HStack(spacing: 4) {
                    Text("거절 사유")
                        .label(.medium)
                        .foreground(DodamColor.Label.alternative)
                    Text("\(outGoingData.rejectReason ?? "선생님께서 외출 신청을 거절하였습니다.")")
                        .body1(.medium)
                        .font(.system(size: 16, weight: .medium))
                        .foreground(DodamColor.Label.normal)
                    Spacer()
                }
            } else {
                VStack(spacing: 4) {
                    DodamLinearProgressView(
                        progress: calculatingDateProgress(
                            startAt: outGoingData.startAt,
                            endAt: outGoingData.endAt,
                            dateFormat: "yyyy-MM-dd'T'HH:mm:ss"
                        ),
                        isDisabled: outGoingData.status == .pending
                    )
                    HStack(spacing: 4) {
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
                }
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 16)
        .background(DodamColor.Background.normal)
        .clipShape(.large)
    }
}
