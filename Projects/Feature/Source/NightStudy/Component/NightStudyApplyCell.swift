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
    
    public init(
        data nightStudyData: NightStudyResponse
    ) {
        self.nightStudyData = nightStudyData
    }
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 12) {
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
                Text({
                    let date = nightStudyData.createdAt.parseString(format: "M월 d일 (E)")
                    return date
                }())
                .label(.medium)
                .foreground(DodamColor.Label.normal)
                .padding(.top, 5)
            }
            .padding([.top, .horizontal], 16)
            VStack(spacing: 12) {
                Text("\(nightStudyData.content)")
                    .body1(.medium)
                    .foreground(DodamColor.Label.normal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                DodamDivider()
                if nightStudyData.status == .rejected {
                    HStack(spacing: 8) {
                        Text("거절 사유")
                            .label(.regular)
                            .foreground(DodamColor.Label.alternative)
                        Text("\(nightStudyData.rejectReason ?? "선생님께서 심야 자습 신청을 거절하였습니다")")
                            .font(.system(size: 16, weight: .medium))
                            .foreground(DodamColor.Label.normal)
                        Spacer()
                    }
                    .padding(.top, 4)
                } else {
                    HStack(alignment: .bottom, spacing: 16) {
                        VStack(spacing: 8) {
                            HStack(alignment: .bottom, spacing: 4) {
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
                                .label(.regular)
                                .foreground(DodamColor.Label.alternative)
                            Text("\(reasonForPhone)")
                                .label(.medium)
                                .foreground(DodamColor.Label.normal)
                            Spacer()
                        }
                        .padding(.top, 4)
                    }
                }
            }
            .padding([.bottom, .horizontal], 16)
        }
        .background(DodamColor.Background.normal)
        .clipShape(.large)
    }
}
