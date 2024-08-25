//
//  NightStudyStatusContainer.swift
//  DodamDodam
//
//  Created by 이민규 on 3/17/24.
//

import SwiftUI
import DDS
import Domain
import Shared

struct NightStudyStatusContainer: View {
    
    private let nightStudyData: NightStudyResponse?
    
    public init(
        data nightStudyData: NightStudyResponse?
    ) {
        self.nightStudyData = nightStudyData
    }
    
    var body: some View {
        if let data = nightStudyData {
            VStack(alignment: .leading, spacing: 12) {
                if data.status == .rejected {
                    SupportingContainer(
                        subTitle: "심야 자습이 거절되었어요",
                        title: "다시 신청하기"
                    )
                } else if data.status == .allowed ||
                            data.status == .pending {
                    HStack(alignment: .bottom, spacing: 4) {
                        Text(data.endAt.nightStudyRemainingTimeText)
                            .heading2(.bold)
                            .foreground(DodamColor.Label.normal)
                        Text("남음")
                            .foreground(DodamColor.Label.alternative)
                            .label(.medium)
                    }
                    VStack(alignment: .leading, spacing: 4) {
                        DodamLinearProgressView(
                            progress: calculatingDateProgress(
                                startAt: data.startAt,
                                endAt: data.endAt,
                                dateFormat: "yyyy-MM-dd"
                            ),
                            isDisabled: data.status == .pending
                        )
                        Text("\(data.endAt.parseString(format: "MM월 dd"))일 까지")
                            .label(.regular)
                            .foreground(DodamColor.Label.alternative)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        } else if nightStudyData == .none {
            SupportingContainer(
                subTitle: "공부할 시간이 필요하다면",
                title: "심야 자습 신청하기"
            )
        } else {
            DodamLoadingView()
                .frame(height: 48)
        }
    }
}
