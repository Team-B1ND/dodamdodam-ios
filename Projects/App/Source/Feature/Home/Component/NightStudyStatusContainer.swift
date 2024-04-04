//
//  NightStudyStatusContainer.swift
//  DodamDodam
//
//  Created by 이민규 on 3/17/24.
//

import SwiftUI
import DDS

struct NightStudyStatusContainer: View {
    
    private let nightStudyData: NightStudyResponse?
    
    public init(
        data nightStudyData: NightStudyResponse?
    ) {
        self.nightStudyData = nightStudyData
    }
    
    var body: some View {
        if let data = nightStudyData {
            HStack(alignment: .top, spacing: 12) {
                if data.status == .rejected {
                    SupportingContainer(
                        subTitle: "외출이 거절되었어요",
                        title: "다시 신청하기"
                    )
                } else {
                    DodamCircularProgressView(
                        progress: 0.7,
                        isDisabled: data.status == .pending
                    )
                    VStack(alignment: .leading, spacing: 4) {
                        Text(data.status == .pending ? "대기 중" : "13시간")
                            .font(.body(.medium))
                            .dodamColor(.onSurfaceVariant)
                        if !(data.status == .pending) {
                            Text("남음")
                                .font(.body(.medium))
                                .dodamColor(.tertiary)
                        }
                        Text("13:00 복귀")
                            .font(.label(.medium))
                            .dodamColor(.tertiary)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        } else {
            SupportingContainer(
                subTitle: "공부할 시간이 필요하다면",
                title: "심야 자습 신청하기"
            )
        }
    }
}
