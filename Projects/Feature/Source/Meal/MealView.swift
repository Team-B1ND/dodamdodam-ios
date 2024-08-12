//
//  MealView.swift
//  DodamDodam
//
//  Created by 이민규 on 3/19/24.
//

import SwiftUI
import DDS
import Domain
import FlowKit
import Shared

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}

struct MealView: View {
    
    @StateObject private var viewModel = MealViewModel()
    @Flow private var flow
    @Namespace private var animation
    @GestureState private var dragOffset = CGSize.zero
    @State private var openCalendar = false
    @State private var scrollOffset: CGFloat = .zero

    private let weekdays = ["일", "월", "화", "수", "목", "금", "토"]
    private let calendar = Calendar.current
    private let animationDuration = 0.4
    
    var body: some View {
        let title = openCalendar ? "급식" : viewModel.selectedCalendar.parseString(format: "yyyy년 M월 급식")
        DodamScrollView.default(title: title) {
            LazyVStack(spacing: 16) {
                VStack(spacing: 16) {
                    if openCalendar {
                        HStack(spacing: 8) {
                            Text(viewModel.selectedCalendar.parseString(format: "yyyy년 M월"))
                                .headline(.medium)
                                .foreground(DodamColor.Label.strong)
                            Spacer()
                            Button {
                                if let date = calendar.date(byAdding: .month, value: -1, to: viewModel.selectedCalendar) {
                                    viewModel.selectedCalendar = date
                                }
                            } label: {
                                Image(icon: .chevronLeft)
                                    .resizable()
                                    .foreground(DodamColor.Primary.normal)
                                    .frame(width: 20, height: 20)
                                    .padding(8)
                            }
                            .scaledButtonStyle()
                            Button {
                                if let date = calendar.date(byAdding: .month, value: 1, to: viewModel.selectedCalendar) {
                                    viewModel.selectedCalendar = date
                                }
                            } label: {
                                Image(icon: .chevronRight)
                                    .resizable()
                                    .foreground(DodamColor.Primary.normal)
                                    .frame(width: 20, height: 20)
                                    .padding(8)
                            }
                            .scaledButtonStyle()
                        }
                    }
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            ForEach(weekdays, id: \.self) { date in
                                Text(date)
                                    .label(.regular)
                                    .foreground(DodamColor.Label.alternative)
                                    .frame(maxWidth: .infinity)
                            }
                        }
                        if openCalendar {
                            ForEach(viewModel.selectedCalendar.weeks, id: \.hashValue) { week in
                                HStack(spacing: 0) {
                                    ForEach(Array(week.enumerated()), id: \.offset) { _, date in
                                        let selected: Bool = date == nil ? false : viewModel.selectedDate.equals(date!, components: [.year, .month, .day])
                                        Button {
                                            withAnimation(.spring(duration: animationDuration)) {
                                                openCalendar = false
                                            }
                                            if !selected, let date {
                                                viewModel.selectedDate = date
                                                viewModel.selectedCalendar = date
                                            }
                                        } label: {
                                            CalendarDateCell(date: date, selected: selected)
                                        }
                                    }
                                }
                            }
                        } else {
                            HStack(spacing: 0) {
                                ForEach(viewModel.selectedDate.weeklyDates, id: \.self) { date in
                                    let selected = viewModel.selectedDate.equals(date, components: [.year, .month, .day])
                                    Button {
                                        withAnimation(.spring(duration: animationDuration)) {
                                            openCalendar = selected
                                        }
                                        if !selected {
                                            viewModel.selectedDate = date
                                            viewModel.selectedCalendar = date
                                        }
                                    } label: {
                                        CalendarDateCell(date: date, selected: selected)
                                    }
                                    .scaledButtonStyle()
                                }
                            }
                            .simultaneousGesture(
                                DragGesture()
                                    .onEnded { value in
                                        if abs(value.translation.width) > 85 || abs(value.translation.height) > 85 {
                                            withAnimation(.spring(duration: animationDuration)) {
                                                openCalendar = true
                                            }
                                        }
                                    }
                            )
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 12)
                DodamDivider()
                if let meals = viewModel.selectedMeal {
                    let meals = Array([meals.breakfast, meals.lunch, meals.dinner].compactMap { $0 }.enumerated())
                    VStack(spacing: 12) {
                        ForEach(meals, id: \.offset) { idx, meal in
                            if let mealType = MealType(rawValue: idx) {
                                MealCell(type: mealType, meal: meal)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .matchedGeometryEffect(id: 0, in: animation)
                }
            }
            .background {
                GeometryReader { geometry in
                    Color.clear
                        .preference(key: ScrollOffsetPreferenceKey.self, value: geometry.frame(in: .named("scrollView")).minY)
                }
            }
        }
        .background(DodamColor.Background.neutral)
        .coordinateSpace(name: "scrollView")
        .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
            self.scrollOffset = value
        }
        .onChange(of: scrollOffset) {
            if $0 > 100 {
                withAnimation(.spring(duration: animationDuration)) {
                    openCalendar = true
                }
            } else if $0 < 48 { // top app bar height
                withAnimation(.spring(duration: animationDuration)) {
                    openCalendar = false
                    viewModel.selectedCalendar = viewModel.selectedDate
                }
            }
        }
        .overlay {
            if viewModel.selectedMeal == nil && !openCalendar {
                VStack(spacing: 12) {
                    Image(icon: .cookedRice)
                        .resizable()
                        .frame(width: 36, height: 36)
                    Text("급식이 없어요")
                        .label(.medium)
                        .foreground(DodamColor.Label.alternative)
                }
                .padding(.vertical, 40)
            }
        }
        .task {
            await viewModel.onAppear()
        }
    }
    //
    //    func isMealTime(_ date: Date, mealType: Int) -> Bool {
    //
    //        let cc = Calendar.current
    //        // 현재 시간의 년, 월, 일
    //        let currentDate = Date()
    //        let currentYear = cc.component(.year, from: currentDate)
    //        let currentMonth = cc.component(.month, from: currentDate)
    //        let currentDay = cc.component(.day, from: currentDate)
    //        let currentHour = cc.component(.hour, from: currentDate)
    //        let currentMinute = cc.component(.minute, from: currentDate)
    //
    //        // 입력된 시간의 년, 월, 일
    //        let year = cc.component(.year, from: date)
    //        let month = cc.component(.month, from: date)
    //        let day = cc.component(.day, from: date)
    //
    //        // 날짜가 오늘인지 확인
    //        guard currentYear == year && currentMonth == month && currentDay == day else {
    //            return false
    //        }
    //
    //        switch mealType {
    //        case 0:
    //            // 아침: ~ 8:20
    //            return (currentHour >= 0 && currentHour < 8) ||
    //            (currentHour == 8 && currentMinute <= 20)
    //        case 1:
    //            // 점심: 8:21 ~ 13:30
    //            return (currentHour == 8 && currentMinute > 20) ||
    //            (currentHour > 8 && currentHour < 13) ||
    //            (currentHour == 13 && currentMinute <= 30)
    //        case 2:
    //            // 저녁: 13:31 ~ 19:10
    //            return (currentHour == 13 && currentMinute > 30) ||
    //            (currentHour > 13 && currentHour < 19) ||
    //            (currentHour == 19 && currentMinute <= 10)
    //        default:
    //            return false
    //        }
    //    }
}

#Preview {
    MealView()
}
