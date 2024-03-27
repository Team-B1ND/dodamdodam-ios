//
//  ScheduleContainer.swift
//  DodamDodam
//
//  Created by 이민규 on 3/17/24.
//

import SwiftUI
import DDS

struct ScheduleContainer: View {
    
    private let scheduleData: [Schedule]?
    
    public init(
        data scheduleData: [Schedule]?
    ) {
        self.scheduleData = scheduleData
    }
    
    var body: some View {
        if let data = scheduleData {
            HStack(alignment: .top, spacing: 12) {
                ForEach(data, id: \.self) { data in
                    VStack(alignment: .leading, spacing: 0) {
                        Text("D - " + { () -> String in
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd"
                            let currentDate = Date()
                            guard let targetDate = dateFormatter.date(from: data.startDate) else {
                                return "오류"
                            }
                            let calendar = Calendar.current
                            let dateComponents = calendar.dateComponents([.day], from: currentDate, to: targetDate)
                            
                            guard let daysDifference = dateComponents.day else {
                                return "오류"
                            }
                            if daysDifference == 0 {
                                return "day"
                            } else {
                                return "\(abs(daysDifference))"
                            }
                        }())
                        .font(.title(.small))
                        .dodamColor(.onSurfaceVariant)
                        
                        Text({ () -> String in
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd"
                            dateFormatter.locale = Locale(identifier: "ko_KR")
                            if let date = dateFormatter.date(from: data.startDate) {
                                dateFormatter.dateFormat = "M월 d일 (E)"
                                return dateFormatter.string(from: date)
                            }
                            return "오류"
                        }())
                        .font(.label(.medium))
                        .dodamColor(.tertiary)
                    }
                }
            }
        } else {
            SupportingContainer(
                subTitle: "한달 간 일정이 없어요",
                title: "전체 일정 확인하기"
            )
        }
    }
}

#Preview {
    let dummy1 = Schedule(
        id: 1,
        name: "학교 폭력 예방 교육",
        place: "강당",
        type: "ACADEMIC",
        startDate: "2024-03-17",
        endDate: "2024-03-17",
        targetGrades: ["GRADE_2"]
    )
    let dummy2 = Schedule(
        id: 2,
        name: "재밌는 일정",
        place: "집",
        type: "ACADEMIC",
        startDate: "2024-03-17",
        endDate: "2024-03-18",
        targetGrades: ["GRADE_ALL"]
    )
    let dummy3 = Schedule(
        id: 2,
        name: "더 재밌는 일정",
        place: "어딘가",
        type: "ACADEMIC",
        startDate: "2024-03-18",
        endDate: "2024-03-18",
        targetGrades: ["GRADE_3"]
    )
    return VStack(spacing: 12) {
        DodamContainer.default(
            title: "가까운 일정",
            icon: Dodam.icon(.calendar)
        ) {
            ScheduleContainer(data: [dummy1, dummy2, dummy3])
        }
        DodamContainer.default(
            title: "가까운 일정",
            icon: Dodam.icon(.calendar)
        ) {
            ScheduleContainer(data: nil)
        }
    }
    .padding(16)
    .background(Dodam.color(.surface))
}
