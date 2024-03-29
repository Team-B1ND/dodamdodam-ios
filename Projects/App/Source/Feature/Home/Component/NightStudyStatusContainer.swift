//
//  NightStudyStatusContainer.swift
//  DodamDodam
//
//  Created by 이민규 on 3/17/24.
//

import SwiftUI
import DDS

struct NightStudyStatusContainer: View {
    
    private let nightStudyData: NightStudy?
    
    public init(
        data nightStudyData: NightStudy?
    ) {
        self.nightStudyData = nightStudyData
    }
    
    var body: some View {
        if let data = nightStudyData {
            HStack(alignment: .top, spacing: 12) {
                if data.status == "DENIED" {
                    SupportingContainer(
                        subTitle: "외출이 거절되었어요",
                        title: "다시 신청하기"
                    )
                } else {
                    DodamCircularProgressView(
                        progress: 0.7,
                        isDisabled: data.status == "PENDING"
                    )
                    VStack(alignment: .leading, spacing: 4) {
                        Text(data.status == "PENDING" ? "대기 중" : "13시간")
                            .font(.body(.medium))
                            .dodamColor(.onSurfaceVariant)
                        if !(data.status == "PENDING") {
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

#Preview {
    let dummyNightStudy1 = NightStudy(
        id: 1,
        content: "content",
        status: "PENDING",
        doNeedPhone: true,
        reasonForPhone: "reasonForPhone",
        student: Student(
            id: 1,
            grade: 3,
            room: 4,
            number: 12,
            name: "이민규"
        ),
        place: "프로그래밍 1실",
        startAt: "yyyy-MM-ss HH:mm:ss",
        endAt: "yyyy-MM-ss HH:mm:ss",
        createdAt: "yyyy-MM-ss HH:mm:ss",
        modifiedAt: "yyyy-MM-ss HH:mm:ss"
    )
    let dummyNightStudy2 = NightStudy(
        id: 2,
        content: "content",
        status: "ALLOWED",
        doNeedPhone: true,
        reasonForPhone: "reasonForPhone",
        student: Student(
            id: 1,
            grade: 3,
            room: 4,
            number: 12,
            name: "이민규"
        ),
        place: "프로그래밍 1실",
        startAt: "yyyy-MM-ss HH:mm:ss",
        endAt: "yyyy-MM-ss HH:mm:ss",
        createdAt: "yyyy-MM-ss HH:mm:ss",
        modifiedAt: "yyyy-MM-ss HH:mm:ss"
    )
    return HStack(spacing: 12) {
        DodamContainer.default(
            title: "외출 외박",
            icon: Dodam.icon(.calendar)
        ) {
            NightStudyStatusContainer(data: dummyNightStudy1)
        }
        DodamContainer.default(
            title: "외출 외박",
            icon: Dodam.icon(.calendar)
        ) {
            NightStudyStatusContainer(data: dummyNightStudy2)
        }
    }
    .padding(16)
    .background(Dodam.color(.surface))
}
