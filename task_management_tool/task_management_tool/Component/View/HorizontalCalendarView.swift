//
//  HorizontalCalendarView.swift
//  task_management_tool
//
//  Created by i564407 on 4/24/24.
//

import SwiftUI

struct HorizontalCalendarView: View {
    @Binding var selectedDate: Date
    @State private var currentMonth = Date()

    init(selectedDate: Binding<Date>) {
        _selectedDate = selectedDate
        // Initialize currentMonth to the first of the month
        if let startOfMonth = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Date())) {
            _currentMonth = State(initialValue: startOfMonth)
        }
    }

    private var daysInMonth: [Date] {
        guard let range = Calendar.current.range(of: .day, in: .month, for: currentMonth) else {
            return []
        }
        return range.compactMap { day -> Date? in
            Calendar.current.date(bySetting: .day, value: day, of: currentMonth)
        }
    }

    private var monthFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }

    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                ScrollViewReader { value in
                    HStack(spacing: 12) {
                        ForEach(daysInMonth, id: \.self) { day in
                            DayView(day: day, isSelected: day == selectedDate, onSelect: {
                                selectedDate = day
                                value.scrollTo(selectedDate, anchor: .center)
                            })
                            .id(day)
                        }
                    }
                    .padding(.horizontal)
                    .onAppear {
                        value.scrollTo(selectedDate, anchor: .center)
                    }
                }
            }
        }
    }
}

struct DayView: View {
    var day: Date
    var isSelected: Bool
    var onSelect: () -> Void
    
    private var dayFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter
    }
    
    private var monthFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        return formatter
    }
    
    private var weekFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter
    }
    
    var body: some View {
        Button(action: onSelect) {
            VStack(spacing: 8) {
                Text(monthFormatter.string(from: day)).font(.system(size: 12, weight: .regular))
                Text(dayFormatter.string(from: day)).font(.system(size: 14, weight: .bold))
                Text(weekFormatter.string(from: day)).font(.system(size: 10, weight: .regular))
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .foregroundColor(isSelected ? .white : .black)
            .background(isSelected ? AppColors.primaryColor : .white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
}
