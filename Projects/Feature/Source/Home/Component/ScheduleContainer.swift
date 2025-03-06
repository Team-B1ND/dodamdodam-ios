//
//  ScheduleContainer.swift
//  DodamDodam
//
//  Created by 이민규 on 3/17/24.
//

import SwiftUI
import DDS
import Domain

struct ScheduleContainer: View {
    
    private let scheduleData: [ScheduleResponse]?
    
    func getSchedule(scheduleResponse: [ScheduleResponse]) -> [ScheduleResponse] {
        var schedules: [ScheduleResponse] = []
        var cnt: Int = 0
        
        for data in scheduleResponse {
            if schedules.count == 0 {
                schedules.append(scheduleResponse[0])
            } else if schedules[0].date == data.date || cnt <= 1 {
                schedules.append(data)
                if schedules[0].date != data.date {
                    cnt += 1
                }
            }
        }
    
    
        print("스케줄 \(schedules)")
        return schedules
    }
    
    init(
        data scheduleData: [ScheduleResponse]?
    ) {
        self.scheduleData = scheduleData
    }
    
    var body: some View {
        VStack(spacing: 10) {
            if let data = scheduleData {
                ForEach(0 ..< min(data.count, 2), id: \.self) { idx in
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(alignment: .bottom, spacing: 4) {
                            Text("\(data[idx].date[0].suffix(2))일")
                                .heading2(.bold)
                                .foreground(DodamColor.Label.normal)
                            
                            let weekdayName = { (dateString: String) -> String in
                                let dateHelper = Date()
                                guard let date = dateHelper.from(string: dateString, format: "yyyy-MM-dd") else {
                                    return "알 수 없음"
                                }
                                return date.parseString(format: "EEEE")
                            }
                            
                            Text("\(weekdayName(data[idx].date[0]))")
                                .label(.medium)
                                .foreground(DodamColor.Label.alternative)
                            
                        }
                        
                        HStack {
                            Circle()
                                .frame(width: 6, height: 6)
                                .foregroundStyle(Color(0xffFFB5B5))
                            Text("\(data[idx].name)")
                            Spacer()
                        }
                    }
                    .padding(.bottom, 10)
                    .padding(.horizontal, 10)
                }
            } else {
                SupportingContainer(
                    subTitle: "한달 간 일정이 없어요",
                    title: "다음 달 일정을 기다려주세요"
                )
            }
        }
        .padding(.top, 6)
    }
}
