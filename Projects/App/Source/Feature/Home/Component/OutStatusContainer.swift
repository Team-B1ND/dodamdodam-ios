//
//  OutStatusContainer.swift
//  DodamDodam
//
//  Created by 이민규 on 3/17/24.
//

import SwiftUI

struct OutStatusContainer: View {
    
    private let data: Out?
    
    public init(
        data: Out?
    ) {
        self.data = data
    }
    
    var body: some View {
        if let data = data {
            HStack(alignment: .top, spacing: 12) {
                if data.status == "DENY" {
                    SupportingContainer(
                        subTitle: "심야 자습이 거절되었어요",
                        title: "다시 신청하기"
                    )
                } else {
                    DodamCircularProgressView(
                        progress: 0.7,
                        isDisabled: data.status == "PENDING"
                    )
                    VStack(alignment: .leading, spacing: 4) {
                        Text(data.status == "PENDING" ? "대기 중" : "13시간")
                            .font(.dodamBody2)
                            .foregroundStyle(Color(.onSurfaceVariant))
                        if !(data.status == "PENDING") {
                            Text("남음")
                                .font(.dodamLabel2)
                                .foregroundStyle(Color(.tertiary))
                        }
                        Text("13:00 복귀")
                            .font(.dodamLabel2)
                            .foregroundStyle(Color(.tertiary))
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

public struct Out: Codable, Hashable {
    let id: Int
    let reason, status: String
    let student: Student
    let startAt, endAt, createdAt, modifiedAt: String
}

public struct Student: Codable, Hashable {
    let id, grade, room, number: Int
    let name: String
}

#Preview {
    let dummyOutData1 = Out(
        id: 1,
        reason: "reason",
        status: "PENDING",
        student: Student(
            id: 1,
            grade: 3,
            room: 4,
            number: 12,
            name: "이민규"
        ),
        startAt: "yyyy-MM-ss HH:mm:ss",
        endAt: "yyyy-MM-ss HH:mm:ss",
        createdAt: "yyyy-MM-ss HH:mm:ss",
        modifiedAt: "yyyy-MM-ss HH:mm:ss"
    )
    let dummyOutData2 = Out(
        id: 1,
        reason: "reason",
        status: "ALLOWED",
        student: Student(
            id: 1,
            grade: 3,
            room: 4,
            number: 12,
            name: "이민규"
        ),
        startAt: "yyyy-MM-ss HH:mm:ss",
        endAt: "yyyy-MM-ss HH:mm:ss",
        createdAt: "yyyy-MM-ss HH:mm:ss",
        modifiedAt: "yyyy-MM-ss HH:mm:ss"
    )
    return VStack(spacing: 12) {
        DodamContainer.default(
            title: "외출 외박",
            icon: Image(.calendar)
        ) {
            OutStatusContainer(data: dummyOutData1)
        }
        DodamContainer.default(
            title: "외출 외박",
            icon: Image(.calendar)
        ) {
            OutStatusContainer(data: dummyOutData2)
        }
        DodamContainer.default(
            title: "외출 외박",
            icon: Image(.calendar)
        ) {
            OutStatusContainer(data: nil)
        }
    }
    .padding(16)
    .background(Color(.surface))
}
