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

struct NightProjectApplyCell: View {
    
    private let nightStudyData: NightStudyProjectResponse
    private let removeAction: () -> Void
    
    init(
        data nightStudyData: NightStudyProjectResponse,
        removeAction: @escaping () -> Void
    ) {
        self.nightStudyData = nightStudyData
        self.removeAction = removeAction
    }
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                DodamTag(nightStudyData.status.text, type: {
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
            Text("\(nightStudyData.description)")
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
                    Text("선생님께서 프로젝트 신청을 거절하였습니다")
                        .body1(.medium)
                        .foreground(DodamColor.Label.normal)
                    Spacer()
                }
            } else {
                VStack(spacing: 4) {
                    DodamLinearProgressView(
                        progress: calculatingDateProgress(
                            startAt: nightStudyData.startAt,
                            endAt: nightStudyData.endAt
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
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 16)
        .background(DodamColor.Background.normal)
        .clipShape(.large)
    }
}
