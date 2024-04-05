//
//  OutStatusContainer.swift
//  DodamDodam
//
//  Created by 이민규 on 3/17/24.
//

import SwiftUI
import DDS

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
                        subTitle: "심야 자습이 거절되었어요",
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
                            .dodamColor(.onSurface)
                        if !(data.status == .pending) {
                            Text("남음")
                                .font(.label(.large))
                                .dodamColor(.onSurfaceVariant)
                        }
                        Text("13:00 복귀")
                            .font(.label(.large))
                            .dodamColor(.onSurfaceVariant)
                    }
                    
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        } else {
            SupportingContainer(
                subTitle: "외출, 외박이 필요하다면",
                title: "외출/외박 신청하기"
            )
        }
    }
}
