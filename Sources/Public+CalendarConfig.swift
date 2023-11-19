//
//  Public+CalendarConfig.swift of CalendarView
//
//  Created by Tomasz Kurylik
//    - Twitter: https://twitter.com/tkurylik
//    - Mail: tomasz.kurylik@mijick.com
//    - GitHub: https://github.com/FulcrumOne
//
//  Copyright ©2023 Mijick. Licensed under MIT License.


import SwiftUI

// MARK: - Calendar Configuration
public extension CalendarConfig {
    func startMonth(_ value: Date) -> Self { MCalendar.startDate = value.start(of: .month); return self }
    func endMonth(_ value: Date) -> Self { MCalendar.endDate = value.end(of: .month); return self }
    func firstWeekday(_ value: MWeekday) -> Self { MCalendar.firstWeekday = value; return self }
    func locale(_ value: Locale) -> Self { MCalendar.locale = value; return self }
}

// MARK: - Views
public extension CalendarConfig {
    func monthLabel(_ builder: @escaping (Date) -> some MonthLabel) -> Self { changing(path: \.monthLabel, to: builder) }
    func weekdaysView(_ builder: @escaping () -> some WeekdaysView) -> Self { changing(path: \.weekdaysView, to: builder) }
    func dayView(_ builder: @escaping (Date, Bool, Binding<Date?>?, Binding<MDateRange?>?) -> some DayView) -> Self { changing(path: \.dayView, to: builder) }
}

// MARK: - Modifiers
public extension CalendarConfig {
    func scrollTo(date: Date?) -> Self { changing(path: \.scrollDate, to: date) }
    func onMonthChange(_ value: @escaping (Date) -> ()) -> Self { changing(path: \.onMonthChange, to: value) }
}


// MARK: - Internal
public struct CalendarConfig: Configurable { public init() {}
    private(set) var monthLabel: (Date) -> any MonthLabel = DefaultMonthLabel.init
    private(set) var weekdaysView: () -> any WeekdaysView = DefaultWeekdaysView.init
    private(set) var dayView: (Date, Bool, Binding<Date?>?, Binding<MDateRange?>?) -> any DayView = DefaultDayView.init

    private(set) var scrollDate: Date? = nil
    private(set) var onMonthChange: (Date) -> () = {_ in}
}