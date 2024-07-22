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
    
    @Environment(\.isFirstLoad) private var isFirstLoad
    
    var body: some View {
        if let data = outData {
            HStack(alignment: .top, spacing: 12) {
                if data.status == .rejected {
                    SupportingContainer(
                        subTitle: "외출/외박이 거절되었어요",
                        title: "다시 신청하기"
                    )
                } else if data.status == .allowed ||
                            data.status == .pending {
                    DodamCircularProgressView(
                        progress: calculatingDateProgress(
                            startAt: data.startAt,
                            endAt: data.endAt,
                            dateFormat: "yyyy-MM-dd'T'HH:mm:ss"
                        ),
                        isDisabled: data.status == .pending
                    )
                    VStack(alignment: .leading, spacing: 4) {
                        Text(data.status == .pending
                             ? "대기 중"
                             : { () -> String in
                            
                            let calendar = Calendar.current
                            let currentDate = Date()
                            
                            let difference = calendar.dateComponents(
                                [.hour, .minute],
                                from: currentDate,
                                to: data.endAt
                            )
                            
                            if let hours = difference.hour, hours >= 1 {
                                return "\(hours)시간"
                            } else if let minutes = difference.minute {
                                return "\(minutes)분"
                            }
                            return ""
                        }()
                        )
                        .label(.regular)
                        .foreground(DodamColor.Label.alternative)
                        if !(data.status == .pending) {
                            Text("남음")
                                .label(.medium)
                                .foreground(DodamColor.Label.alternative)
                        } else {
                            Text("\(data.startAt.parseString(format: "HH:mm")) 출발")
                                .label(.regular)
                                .foreground(DodamColor.Label.alternative)
                        }
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
