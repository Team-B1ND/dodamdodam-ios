//
//  MealView.swift
//  DodamDodam
//
//  Created by 이민규 on 3/19/24.
//

import SwiftUI
import DDS

struct MealView: View {
    
    @StateObject var viewModel = MealViewModel()
    @Flow var flow
    
    func isToday(_ dateStr: String) -> Bool {
        let date = dateStr.parseDate(format: "yyyy-MM-dd") ?? Date()
        let today = Date()
        return Calendar.current.isDate(date, inSameDayAs: today)
    }
    
    var body: some View {
        DodamScrollView.default(title: "급식") {
            LazyVStack(spacing: 20) {
                if let datas = viewModel.mealData {
                    if !datas.isEmpty {
                        ForEach({ () -> [MealResponse] in
                            datas.filter {
                                let date = $0.date.parseDate(format: "yyyy-MM-dd")
                                guard let date else {
                                    return false
                                }
                                let today = Calendar.current.startOfDay(for: Date())
                                return $0.exists && date >= today
                            }
                        }(), id: \.self) { datas in
                            let date = datas.date.parseDate(format: "yyyy-MM-dd")
                            Text({ () -> String in
                                guard let date else {
                                    return "시간 오류"
                                }
                                let formattedDate = date.parseString(format: "M월 d일 EEEE")
                                return formattedDate
                            }())
                            .font(.body(.medium))
                            .dodamColor(
                                isToday(datas.date)
                                ? .onPrimary
                                : .onSecondaryContainer
                            )
                            .padding(.vertical, 4)
                            .frame(width: 218, height: 31)
                            .background(
                                isToday(datas.date)
                                ? Dodam.color(.primary).opacity(0.65)
                                : Dodam.color(.secondaryContainer)
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 32))
                            
                            LazyVStack(spacing: 12) {
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
                                        guard let date = datas.date.parseDate(
                                            format: "yyyy-MM-dd"
                                        ) else {
                                            return .now
                                        }
                                        return date
                                    }()
                                    if let data = data {
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
                                                .background(
                                                    isMealTime(date, mealType: idx)
                                                    ? Dodam.color(.primary)
                                                    : Dodam.color(.onSurfaceVariant)
                                                )
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
                } else {
                    DodamLoadingView()
                }
            }
            .padding(.horizontal, 16)
        }
        .background(Dodam.color(.surface))
        .task {
            await viewModel.onAppear()
        }
        .refreshable {
            await viewModel.onRefresh()
        }
    }
    
    func isMealTime(_ date: Date, mealType: Int) -> Bool {
        
        let cc = Calendar.current
        // 현재 시간의 년, 월, 일
        let currentDate = Date()
        let currentYear = cc.component(.year, from: currentDate)
        let currentMonth = cc.component(.month, from: currentDate)
        let currentDay = cc.component(.day, from: currentDate)
        let currentHour = cc.component(.hour, from: currentDate)
        let currentMinute = cc.component(.minute, from: currentDate)
        
        // 입력된 시간의 년, 월, 일
        let year = cc.component(.year, from: date)
        let month = cc.component(.month, from: date)
        let day = cc.component(.day, from: date)
        
        // 날짜가 오늘인지 확인
        guard currentYear == year && currentMonth == month && currentDay == day else {
            return false
        }
        
        switch mealType {
        case 0:
            // 아침: ~ 8:20
            return (currentHour >= 0 && currentHour < 8) ||
                   (currentHour == 8 && currentMinute <= 20)
        case 1:
            // 점심: 8:21 ~ 13:30
            return (currentHour == 8 && currentMinute > 20) ||
                   (currentHour > 8 && currentHour < 13) ||
                   (currentHour == 13 && currentMinute <= 30)
        case 2:
            // 저녁: 13:31 ~ 19:10
            return (currentHour == 13 && currentMinute > 30) ||
                   (currentHour > 13 && currentHour < 19) ||
                   (currentHour == 19 && currentMinute <= 10)
        default:
            return false
        }
    }
}

#Preview {
    MealView()
}
