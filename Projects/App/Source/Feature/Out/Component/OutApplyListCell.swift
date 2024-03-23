//
//  OutApplyListCell.swift
//  DodamDodam
//
//  Created by 이민규 on 3/23/24.
//

import SwiftUI
import DDS
import Combine

struct OutApplyListCell: View {
    
    private let data: Out
    
    init(
        data: Out
    ) {
        self.data = data
    }
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 12) {
                ZStack {
                    Text({ () -> String in
                        switch data.status {
                        case "ALLOWED": return "승인됨"
                        case "PENDING": return "대기중"
                        case "DENY": return "거절됨"
                        default: return ""
                        }
                    }())
                    .font(.title(.small))
                    .dodamColor(.onPrimary)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 12)
                }
                .frame(height: 27)
                .background({ () -> Color in
                    switch data.status {
                    case "ALLOWED": return Dodam.color(.primary)
                    case "PENDING": return Dodam.color(.tertiary)
                    case "DENY": return Dodam.color(.error)
                    default: return Dodam.color(.primary)
                    }
                }())
                .clipShape(RoundedRectangle(cornerRadius: 32))
                Spacer()
                Text({ () -> String in
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    dateFormatter.locale = Locale(identifier: "ko_KR")
                    if let date = dateFormatter.date(from: data.createdAt) {
                        dateFormatter.dateFormat = "M월 d일 (E)"
                        return dateFormatter.string(from: date)
                    }
                    return "오류"
                }())
                .font(.label(.large))
                .dodamColor(.tertiary)
                .padding(.top, 5)
            }
            .padding([.top, .horizontal], 16)
            VStack(spacing: 12) {
                Text("\(data.reason)")
                    .font(.body(.medium))
                    .dodamColor(.onBackground)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Rectangle()
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(Dodam.color(.secondary))
                if data.status == "DENY" {
                    HStack(spacing: 8) {
                        Text("거절 사유")
                            .font(.label(.large))
                            .dodamColor(.tertiary)
                        // 나중에 거절 사유 추가되면 데이터 넣기
                        Text("그냥 맘에 안들어서 거절함")
                            .font(.body(.medium))
                            .dodamColor(.onSurfaceVariant)
                        Spacer()
                    }
                    .padding(.top, 4)
                } else {
                    
                }
            }
            .padding([.bottom, .horizontal], 16)
        }
        .background(Dodam.color(.surfaceContainer))
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}

#Preview {
    let outData1: Out = Out(
        id: 1,
        reason: "맛있는 음식을 위해 외출 다녀오겠습니다.",
        status: "ALLOWED",
        student: Student(
            id: 1,
            grade: 3,
            room: 4,
            number: 12,
            name: "이민규"
        ),
        startAt: "2024-03-24 17:00:00",
        endAt: "2024-03-26 12:00:00",
        createdAt: "2024-03-23 17:00:00",
        modifiedAt: "2024-03-23 17:00:00"
    )
    let outData2: Out = Out(
        id: 1,
        reason: "맛있는 음식을 위해 외출 다녀오겠습니다.",
        status: "DENY",
        student: Student(
            id: 1,
            grade: 3,
            room: 4,
            number: 12,
            name: "이민규"
        ),
        startAt: "2024-03-24 17:00:00",
        endAt: "2024-03-26 12:00:00",
        createdAt: "2024-03-23 17:00:00",
        modifiedAt: "2024-03-23 17:00:00"
    )
    return VStack(spacing: 20) {
        OutApplyListCell(data: outData1)
        OutApplyListCell(data: outData2)
    }
    .padding(.horizontal, 16)
    .frame(maxHeight: .infinity)
    .background(Dodam.color(.surface))
}
