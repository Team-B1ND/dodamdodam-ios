//
//  ScheduleContainer.swift
//  DodamDodam
//
//  Created by 이민규 on 3/17/24.
//

import SwiftUI

struct ScheduleContainer: View {
    
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
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            ForEach([dummy1, dummy2, dummy3], id: \.self) { data in
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
                    .font(.dodamTitle3)
                    .foregroundStyle(Color(.onSurfaceVariant))
                    
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
                    .font(.dodamLabel2)
                    .foregroundStyle(Color(.tertiary))
                }
            }
        }
    }
}

struct Schedule: Codable, Hashable {
    let id: Int
    let name: String
    let place: String
    let type: String
    let startDate: String
    let endDate: String
    let targetGrades: [String]
}

#Preview {
    DodamContainer.default(
        title: "가까운 일정",
        icon: Image(.calendar)
    ) {
        ScheduleContainer()
    }
    .arrowButtonAction {
        print("화살표 액션")
    }
    .padding(16)
    .background(Color(.surface))
}
