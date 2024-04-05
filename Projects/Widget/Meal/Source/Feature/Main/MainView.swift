//
//  MainView.swift
//  DodamDodam-MealWidget
//
//  Created by Mercen on 4/5/24.
//

import SwiftUI

struct MainView: View {
    
    @Environment(\.widgetFamily) var widgetFamily
    var entry: Provider.Entry
    
    // MARK: - 급식 시간 결정
    var whichMeal: MealTime {
        let date = entry.date
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let currentTime = hour * 60 + minute
        
        if currentTime >= 6 * 60 + 20 && currentTime < 8 * 60 + 20 {
            return .breakfast
        } else if currentTime >= 8 * 60 + 20 && currentTime < 13 * 60 + 20 {
            return .lunch
        } else if currentTime >= 13 * 60 + 20 && currentTime < 19 * 60 + 10 {
            return .dinner
        } else {
            return .none
        }
    }
    
    @ViewBuilder func makeIcon(time: MealTime, type: Bool) -> some View {
        HStack {
            
            // MARK: - 이미지
            Image(time.rawValue)
                .resizable()
                .scaledToFit()
                .frame(width: type ? 30 : 25)
            
            if type {
                Spacer()
            }
            
            // MARK: - 이름
            Text(time.toString)
                .font(.system(size: type ? 12 : 10, weight: .semibold))
                .foregroundColor(.white)
                .padding(.vertical, type ? 5 : 4)
                .padding(.horizontal, type ? 10 : 8)
                .background(Color(time.rawValue))
                .clipShape(Capsule())
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            // MARK: - 소형 위젯 (systemSmall)
            if widgetFamily == .systemSmall {
                
                /// 아이콘과 이름
                makeIcon(time: whichMeal, type: true)
                Spacer()
                
                /// 급식 정보
                Text((entry.meal[whichMeal] ?? "")
                    .replacingOccurrences(of: "*", with: ""))
                    .font(.system(size: 12, weight: .regular))
            }
            
            // MARK: - 중간 위젯 (systemMedium)
            else {
                ForEach([MealTime.breakfast, .lunch, .dinner], id: \.self) { time in
                    HStack {
                        
                        /// 아이콘과 이름
                        makeIcon(time: time, type: false)
                        
                        /// 급식 정보
                        Text((entry.meal[time] ?? "")
                            .replacingOccurrences(of: "*", with: ""))
                            .font(.system(size: 11, weight: .regular))
                            .lineLimit(2)
                        Spacer()
                    }
                    .frame(height: 30)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .widgetBackground(Color("WidgetBackground"))
        .widgetURL(URL(string: "widget://meal")!)
    }
}
