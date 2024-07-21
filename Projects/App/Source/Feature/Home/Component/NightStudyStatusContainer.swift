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
    
    @Environment(\.isFirstLoad) private var isFirstLoad
    
    var body: some View {
        if let data = nightStudyData {
            HStack(alignment: .top, spacing: 12) {
                if data.status == .rejected {
                    SupportingContainer(
                        subTitle: "심야 자습이 거절되었어요",
                        title: "다시 신청하기"
                    )
                } else if data.status == .allowed ||
                            data.status == .pending {
                    DodamCircularProgressView(
                        progress: calculatingDateProgress(
                            startAt: data.startAt,
                            endAt: data.endAt,
                            dateFormat: "yyyy-MM-dd"
                        ),
                        isDisabled: data.status == .pending
                    )
                    VStack(alignment: .leading, spacing: 4) {
                        Text(data.status == .pending
                             ? "대기 중"
                             : { () -> String in
                            
                            let days = getDate(.day, date: data.endAt)
                            
                            return "\(days)일"
                        }()
                        )
                        .body(.medium)
//                        .dodamColor(.onSurface) // TODO: Add color
                        if !(data.status == .pending) {
                            Text("남음")
//                                .font(.body(.small))
//                                .dodamColor(.onSurfaceVariant)
                        }
                        Text({ () -> String in
                            let month = getDate(.month, date: data.endAt)
                            let day = getDate(.day, date: data.endAt)
                            let string = "\(month).\(day)"
                            return "\(string)까지"
                        }())
//                        .font(.label(.large)) // TODO: Add color
//                        .dodamColor(.onSurfaceVariant)
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
