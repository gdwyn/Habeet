//
//  WeekDays.swift
//  Habeet
//
//  Created by Godwin IE on 21/11/2023.
//

import Foundation

class WeekDays: ObservableObject {
    @Published var currentWeek: [Date] = []

    //initialize func
    init() {
        fetchCurrentWeek()
    }
    
    func fetchCurrentWeek() {
        
        let today = Date()
        let calendar = Calendar.current
        
        let week = calendar.dateInterval(of: .weekOfMonth, for: today)
        
        guard let firstWeekDay = week?.start else {
            return
        }
        
        (1...14).forEach { day in
            
            if let weekDay = calendar.date(byAdding: .day, value: day, to: firstWeekDay) {
                currentWeek.append(weekDay)
            }
            
        }
    }
    
    //extracting date
    func extractDate(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = format
        
        return formatter.string(from: date)
    }
}

