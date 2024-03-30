//
//  ScheduleContainer.swift
//  DodamDodam
//
//  Created by 이민규 on 3/17/24.
//

import SwiftUI
import DDS

struct ScheduleContainer: View {
    
    private let scheduleData: [ScheduleResponse]?
    
    public init(
        data scheduleData: [ScheduleResponse]?
    ) {
        self.scheduleData = scheduleData
    }
    
    var body: some View {
        if let data = scheduleData {
            HStack(alignment: .top, spacing: 12) {
                ForEach(data, id: \.self) { data in
                    VStack(alignment: .leading, spacing: 0) {
                        Text("\(data.name)")
//                        Text("D - " + { () -> String in
//                            let dateFormatter = DateFormatter()
//                            dateFormatter.dateFormat = "yyyy-MM-dd"
//                            let currentDate = Date()
//                            guard let targetDate = dateFormatter.date(from: data.) else {
//                                return "오류"
//                            }
//                            let calendar = Calendar.current
//                            let dateComponents = calendar.dateComponents([.day], from: currentDate, to: targetDate)
//                            
//                            guard let daysDifference = dateComponents.day else {
//                                return "오류"
//                            }
//                            if daysDifference == 0 {
//                                return "day"
//                            } else {
//                                return "\(abs(daysDifference))"
//                            }
//                        }())
//                        .font(.title(.small))
//                        .dodamColor(.onSurfaceVariant)
//                        
//                        Text({ () -> String in
//                            let dateFormatter = DateFormatter()
//                            dateFormatter.dateFormat = "yyyy-MM-dd"
//                            dateFormatter.locale = Locale(identifier: "ko_KR")
//                            if let date = dateFormatter.date(from: data.startDate) {
//                                dateFormatter.dateFormat = "M월 d일 (E)"
//                                return dateFormatter.string(from: date)
//                            }
//                            return "오류"
//                        }())
//                        .font(.label(.medium))
//                        .dodamColor(.tertiary)
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
