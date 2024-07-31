//
//  OutStatusContainer.swift
//  DodamDodam
//
//  Created by 이민규 on 3/17/24.
//

import SwiftUI
import DDS
import Domain
import Shared

struct OutStatusContainer: View {
    
    private let outData: OutGoingResponse?
    
    public init(
        data outData: OutGoingResponse?
    ) {
        self.outData = outData
    }
    
    var body: some View {
        if let data = outData {
            VStack(alignment: .leading, spacing: 12) {
                if data.status == .rejected {
                    SupportingContainer(
                        subTitle: "외출/외박이 거절되었어요",
                        title: "다시 신청하기"
                    )
                } else if data.status == .allowed ||
                            data.status == .pending {
                    HStack(alignment: .bottom, spacing: 4) {
                        Text(data.endAt.remainingTimeText)
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
                                dateFormat: "yyyy-MM-dd'T'HH:mm:ss"
                            ),
                            isDisabled: data.status == .pending
                        )
                        Text("\(data.endAt.parseString(format: "HH:mm")) 복귀")
                            .label(.regular)
                            .foreground(DodamColor.Label.alternative)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        } else if outData == .none {
            SupportingContainer(
                subTitle: "외출, 외박이 필요하다면",
                title: "외출/외박 신청하기"
            )
        } else {
            DodamLoadingView()
                .frame(height: 48)
        }
    }
}
