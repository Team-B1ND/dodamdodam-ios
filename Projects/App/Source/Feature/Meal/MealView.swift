//
//  MealView.swift
//  DodamDodam
//
//  Created by 이민규 on 3/19/24.
//

import SwiftUI
import DDS

struct MealView: View {
    
    @InjectObject var viewModel: MealViewModel
    @Flow var flow
    
    func isToday(_ dateStr: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: dateStr) else {
            return false
        }
        let today = Date()
        return Calendar.current.isDate(date, inSameDayAs: today)
    }
    
    var body: some View {
        DodamScrollView.default(title: "급식") {
            VStack(spacing: 20) {
                if let datas = viewModel.mealData {
                    ForEach({ () -> [MealResponse] in
                        datas.filter {
                            let date = $0.date.parseDate()
                            guard let date else {
                                return false
                            }
                            let today = Calendar.current.startOfDay(for: Date())
                            return $0.exists && date >= today
                        }
                    }(), id: \.self) { datas in
                        let date = datas.date.parseDate()
                        Text({ () -> String in
                            guard let date else {
                                return "datas.date 가 없습니다"
                            }
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd"
                            dateFormatter.locale = Locale(identifier: "ko_KR")
                            dateFormatter.dateFormat = "M월 d일 EEEE"
                            let formattedDate = dateFormatter.string(from: date)
                            return formattedDate
                        }())
                        .font(.body(.medium))
                        .dodamColor(
                            isToday(datas.date) ? .onPrimary : .onSecondaryContainer
                        )
                        .padding(.vertical, 4)
                        .frame(width: 218, height: 31)
                        .background(
                            isToday(datas.date)
                            ? Dodam.color(.primary).opacity(0.65)
                            : Dodam.color(.secondaryContainer)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 32))
                        
                        VStack(spacing: 12) {
                            ForEach(0..<3, id: \.self) { idx in
                                let data: Meal? = {
                                    switch idx {
                                    case 0: datas.breakfast
                                    case 1: datas.lunch
                                    case 2: datas.dinner
                                    default: nil
                                    }
                                }()
                                let date: Date = {
                                    
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.dateFormat = "yyyy-MM-dd"
                                    guard let date = dateFormatter.date(from: datas.date) else {
                                        return .now
                                    }
                                    return date
                                }()
                                
                                let isMealTime = isMealTime(date, mealType: idx)
                                
                                let backgroundColor = isMealTime ? Dodam.color(.primary) : Dodam.color(.onSurfaceVariant)
                                
                                if let data = data
                                {
                                    VStack(spacing: 16) {
                                        HStack(spacing: 12) {
                                            ZStack {
                                                Text({ () -> String in
                                                    switch idx {
                                                    case 0: return "아침"
                                                    case 1: return "점심"
                                                    case 2: return "저녁"
                                                    default: return ""
                                                    }
                                                }())
                                                .font(.body(.medium))
                                                .dodamColor(.onPrimary)
                                            }
                                            .frame(width: 52, height: 27)
                                            .background(backgroundColor)
                                            .clipShape(RoundedRectangle(cornerRadius: 32))
                                            Spacer()
                                            Text("\(Int(data.calorie))Kcal")
                                                .font(.label(.large))
                                                .dodamColor(.onSurfaceVariant)
                                                .padding(.top, 5)
                                        }
                                        .padding([.top, .horizontal], 16)
                                        Text(data.details.map { $0.name }.joined(separator: "\n"))
                                            .font(.body(.medium))
                                            .dodamColor(.onSurface)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding([.bottom, .horizontal], 16)
                                    }
                                    .background(Dodam.color(.surfaceContainer))
                                    .clipShape(RoundedRectangle(cornerRadius: 18))
                                }
                            }
                        }
                    }
                } else {
                    Text("이번 달 급식이 없어요")
                        .font(.system(size: 16, weight: .medium))
                        .dodamColor(.tertiary)
                        .padding(.top, 20)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal, 16)
        }
        .background(Dodam.color(.surface))
        .task {
            await viewModel.onAppear()
        }
    }
    
    func isMealTime(_ date: Date, mealType: Int) -> Bool {
        let c = Calendar.current
        // 현재 시간의 년, 월, 일
        let currentDate = Date()
        let currentYear = c.component(.year, from: currentDate)
        let currentMonth = c.component(.month, from: currentDate)
        let currentDay = c.component(.day, from: currentDate)
        let currentHour = c.component(.hour, from: currentDate)
        let currentMinute = c.component(.minute, from: currentDate)
        
        // 입력된 시간의 년, 월, 일
        let year = c.component(.year, from: date)
        let month = c.component(.month, from: date)
        let day = c.component(.day, from: date)
        
        // 날짜가 오늘인지 확인
        guard currentYear == year && currentMonth == month && currentDay == day else {
            return false
        }
//        print(currentDate, currentYear, currentMonth, currentDay, currentHour, currentMinute)
        
        switch mealType {
        case 0:
            // 아침: ~ 8:20
            return (currentHour >= 0 && currentHour < 8) || (currentHour == 8 && currentMinute <= 20)
        case 1:
            // 점심: 8:21 ~ 13:30
            return (currentHour == 8 && currentMinute > 20) || (currentHour > 8 && currentHour < 13) || (currentHour == 13 && currentMinute <= 30)
        case 2:
            // 저녁: 13:31 ~ 19:10
            return (currentHour == 13 && currentMinute > 30) || (currentHour > 13 && currentHour < 19) || (currentHour == 19 && currentMinute <= 10)
        default:
            return false
        }
    }
}

#Preview {
    MealView()
}
