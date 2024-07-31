//
//  NightStudyApplyCell.swift
//  DodamDodam
//
//  Created by 이민규 on 3/29/24.
//

import SwiftUI
import DDS
import Combine
import Domain
import Shared

struct NightStudyApplyCell: View {
    
    private let nightStudyData: NightStudyResponse
    private let removeAction: () -> Void
    
    public init(
        data nightStudyData: NightStudyResponse,
        removeAction: @escaping () -> Void
    ) {
        self.nightStudyData = nightStudyData
        self.removeAction = removeAction
    }
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                DodamTag({
                    switch nightStudyData.status {
                    case .allowed: "승인됨"
                    case .pending: "대기중"
                    case .rejected: "거절됨"
                    }
                }(), type: {
                    switch nightStudyData.status {
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
            Text("\(nightStudyData.content)")
                .body1(.medium)
                .foreground(DodamColor.Label.normal)
                .frame(maxWidth: .infinity, alignment: .leading)
            DodamDivider()
            HStack(alignment: .bottom, spacing: 4) {
                Text(nightStudyData.endAt.remainingTimeText)
                    .heading2(.bold)
                    .foreground(DodamColor.Label.normal)
                Text("남음")
                    .label(.medium)
                    .foreground(DodamColor.Label.alternative)
                Spacer()
            }
            if nightStudyData.status == .rejected {
                HStack(spacing: 8) {
                    Text("거절 사유")
                        .label(.medium)
                        .foreground(DodamColor.Label.alternative)
                    Text("\(nightStudyData.rejectReason ?? "선생님께서 심야 자습 신청을 거절하였습니다")")
                        .body1(.medium)
                        .foreground(DodamColor.Label.normal)
                    Spacer()
                }
            } else {
                VStack(spacing: 4) {
                    DodamLinearProgressView(
                        progress: calculatingDateProgress(
                            startAt: nightStudyData.startAt,
                            endAt: nightStudyData.endAt,
                            dateFormat: "yyyy-MM-dd"
                        ),
                        isDisabled: nightStudyData.status == .pending
                    )
                    HStack(spacing: 4) {
                        Text("시작")
                            .label(.medium)
                            .foreground(DodamColor.Label.alternative)
                        Text(nightStudyData.startAt.parseString(format: "M월 d일"))
                            .body1(.medium)
                            .foreground(DodamColor.Label.neutral)
                        Spacer()
                        Text("종료")
                            .label(.medium)
                            .foreground(DodamColor.Label.alternative)
                        Text(nightStudyData.endAt.parseString(format: "M월 d일"))
                            .body1(.medium)
                            .foreground(DodamColor.Label.neutral)
                    }
                }
                if let reasonForPhone = nightStudyData.reasonForPhone,
                   nightStudyData.doNeedPhone {
                    HStack(spacing: 8) {
                        Text("휴대폰 사유")
                            .label(.regular)
                            .foreground(DodamColor.Label.alternative)
                        Text("\(reasonForPhone)")
                            .label(.medium)
                            .foreground(DodamColor.Label.normal)
                        Spacer()
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
