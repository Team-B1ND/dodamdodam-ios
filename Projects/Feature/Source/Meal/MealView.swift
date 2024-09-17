//
//  MealView.swift
//  DodamDodam
//
//  Created by 이민규 on 3/19/24.
//

import SwiftUI
import DDS
import Domain
import Shared
import SwiftUIIntrospect

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}

struct MealView: View {
    @StateObject private var viewModel = MealViewModel()
    @State private var posY: CGFloat = .zero {
        didSet {
            if posY > 0 {
                posY = 0
            } else if posY < -calendarSize.height {
                posY = -calendarSize.height
            }
        }
    }
    private var adjustedPosY: CGFloat {
        posY + calendarSize.height
    }
    @State private var calendarRowSize: CGSize?
    @State private var calendarSize: CGSize = .zero
    @State private var headerSize: CGSize = .zero
    @State private var openCalendar = false
    
    private var adjustedCalendarHeight: CGFloat? {
        guard let minHeight = calendarRowSize?.height else { return nil }
        let maxHeight = max(minHeight, calendarSize.height)
        return (adjustedPosY - minHeight * scrollRate + minHeight).clamped(to: minHeight...maxHeight)
    }
    private var weeks: [[Date?]] {
        viewModel.selectedCalendar.weeks
    }
    // 선택된 날짜가 몇 주 인지
    private var selectedDateWeekCount: Int {
        for (idx, week) in Array(weeks.enumerated()) {
            for date in week {
                guard let date else { continue }
                if date.equals(viewModel.selectedDate, components: [.year, .month, .day]) {
                    return idx
                }
            }
        }
        return 0
    }
    private var scrollRate: CGFloat {
        adjustedPosY / calendarSize.height
    }
    
    var body: some View {
        VStack(spacing: 0) {
            let title = viewModel.selectedCalendar.parseString(format: "M월 급식")
            DodamTopAppBar.default(title: title)
            ZStack(alignment: .top) {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        Spacer().frame(height: headerSize.height + abs(posY))
                        if let meals = viewModel.selectedMeal {
                            LazyVStack(spacing: 12) {
                                ForEach(Array(meals.meals.enumerated()), id: \.offset) { idx, meal in
                                    if let mealType = MealType(rawValue: idx) {
                                        MealCell(type: mealType, meal: meal)
                                    }
                                }
                            }
                            .padding(.top, 16)
                            .padding(.horizontal, 16)
                            .padding(.bottom, 54)
                        } else {
                            Color.clear.frame(height: UIScreen.main.bounds.height)
                        }
                    }
                    .background(
                        GeometryReader { inner in
                            Color.clear.preference(
                                key: ScrollOffsetPreferenceKey.self,
                                value: inner.frame(in: .named("scrollView")).origin.y
                            )
                        }
                    )
                }
                .introspect(.scrollView, on: .iOS(.v13, .v14, .v15, .v16, .v17, .v18)) { view in
                    view.bounces = false
                }
                .coordinateSpace(name: "scrollView")
                .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                    self.posY = value
                    openCalendar = value > -calendarSize.height / 2
                }
                .overlay {
                    if viewModel.selectedMeal == nil {
                        VStack(spacing: 12) {
                            Image(icon: .cookedRice)
                                .resizable()
                                .frame(width: 36, height: 36)
                            Text("급식이 없어요")
                                .label(.medium)
                                .foreground(DodamColor.Label.alternative)
                        }
                        .drawingGroup()
                        .padding(.top, headerSize.height)
                    }
                }
                makeCalendar()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            // TODO: ScrollView에 있던 거 그대로 갖고 왔습니다. 나중에 Extension으로 분리할 것.
            .mask(alignment: .bottom) {
                VStack(spacing: 0) {
                    Color.black
                    LinearGradient(
                        colors: [.black, .clear],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(height: 150)
                }
                .ignoresSafeArea()
            }
        }
        .background(DodamColor.Background.neutral)
        .task {
            await viewModel.onAppear()
        }
    }
    
    @ViewBuilder
    private func makeCalendar() -> some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                ForEach(["일", "월", "화", "수", "목", "금", "토"], id: \.self) { date in
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
                            .disabled(
                                !openCalendar &&
                                (date == nil || !viewModel.selectedDate.equals(date!, components: [.weekOfYear]))
                            )
                        }
                    }
                    .onReadSize { size in
                        self.calendarRowSize = size
                    }
                }
            }
            .offset(
                y: (scrollRate - 1)
                * (calendarRowSize?.height ?? 36)
                * CGFloat(selectedDateWeekCount)
            )
            .onReadSize {
                self.calendarSize = $0
            }
            .frame(height: adjustedCalendarHeight, alignment: .top)
            .padding(.bottom, 8)
            .clipped()
            DodamDivider()
                .padding(.top, 8)
        }
        .padding(.horizontal, 16)
        .background(DodamColor.Background.neutral)
        .onReadSize { size in
            self.headerSize = size
        }
    }
}

#Preview {
    MealView()
}
