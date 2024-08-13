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

struct MealView: View {
    
    @StateObject private var viewModel = MealViewModel()
    @Flow private var flow
    
    @State private var dragPosY: CGFloat = .zero
    @State private var calendarRowSize: CGSize?
    @State private var calendarSize: CGSize = .zero
    @State private var openCalendar: Bool = false
    
    private let weekdays = ["일", "월", "화", "수", "목", "금", "토"]
    private let calendar = Calendar.current
    
    private var adjustedCalendarHeight: CGFloat? {
        guard let minHeight = calendarRowSize?.height else {
            return nil
        }
        let maxHeight = max(minHeight, calendarSize.height)
        return (dragPosY + minHeight * scrollRate).clamped(to: minHeight...maxHeight)
    }
    
    private var weeks: [[Date?]] {
        viewModel.selectedCalendar.weeks
    }
    
    // 선택된 날짜가 몇 주 인지
    private var selectedDateWeekCount: Int {
        for (idx, week) in Array(weeks.enumerated()) {
            for date in week {
                guard let date else {
                    continue
                }
                if date.equals(viewModel.selectedDate, components: [.year, .month, .day]) {
                    return idx
                }
            }
        }
        return 0
    }
    
    private var scrollRate: CGFloat {
        1 - dragPosY / calendarSize.height
    }
    
    var body: some View {
        VStack(spacing: 16) {
            let title = viewModel.selectedCalendar.parseString(format: "M월 급식")
            DodamTopAppBar.default(title: title)
            makeCalendar()
            DodamDivider()
            if let meals = viewModel.selectedMeal {
                LazyVStack(spacing: 16) {
                    VStack(spacing: 12) {
                        ForEach(Array(meals.meals.enumerated()), id: \.offset) { idx, meal in
                            if let mealType = MealType(rawValue: idx) {
                                MealCell(type: mealType, meal: meal)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            } else {
                VStack(spacing: 12) {
                    Image(icon: .cookedRice)
                        .resizable()
                        .frame(width: 36, height: 36)
                    Text("급식이 없어요")
                        .label(.medium)
                        .foreground(DodamColor.Label.alternative)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .drawingGroup()
            }
        }
        .background(DodamColor.Background.neutral)
        .frame(maxHeight: .infinity)
        .task {
            await viewModel.onAppear()
        }
        .gesture(
            DragGesture()
                .onChanged { value in
                    let rangeHeight = if openCalendar {
                        calendarSize.height + value.translation.height
                    } else {
                        value.translation.height
                    }
                    dragPosY = rangeHeight.clamped(to: 0...calendarSize.height)
                }
                .onEnded { value in
                    withAnimation(.easeOut(duration: 0.2)) {
                        if dragPosY > calendarSize.height / 2 {
                            openCalendar = true
                            dragPosY = calendarSize.height
                        } else {
                            openCalendar = false
                            dragPosY = 0
                        }
                    }
                }
        )
    }
    
    @ViewBuilder
    private func makeCalendar() -> some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                ForEach(weekdays, id: \.self) { date in
                    Text(date)
                        .label(.regular)
                        .foreground(DodamColor.Label.alternative)
                        .frame(maxWidth: .infinity)
                }
            }
            VStack(spacing: 0) {
                ForEach(weeks, id: \.hashValue) { week in
                    HStack(spacing: 0) {
                        ForEach(Array(week.enumerated()), id: \.offset) { _, date in
                            let selected: Bool = if let date {
                                viewModel.selectedDate.equals(date, components: [.year, .month, .day])
                            } else {
                                false
                            }
                            Button {
                                if !selected, let date {
                                    viewModel.selectedDate = date
                                    viewModel.selectedCalendar = date
                                }
                            } label: {
                                CalendarDateCell(date: date, selected: selected)
                            }
                            .scaledButtonStyle()
                        }
                    }
                    .onReadSize { size in
                        self.calendarRowSize = size
                    }
                }
            }
            .offset(y: -scrollRate * (calendarRowSize?.height ?? 36) * CGFloat(selectedDateWeekCount))
            .onReadSize {
                self.calendarSize = $0
            }
            .frame(height: adjustedCalendarHeight, alignment: .top)
            .clipped()
        }
        .padding(.horizontal, 16)
        .background(DodamColor.Background.neutral)
    }
}

#Preview {
    MealView()
}
