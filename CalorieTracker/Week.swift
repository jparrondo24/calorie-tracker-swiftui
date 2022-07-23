//
//  Week.swift
//  CalorieTracker
//
//  Created by Justin Parrondo on 7/19/22.
//

import Foundation

class Week: ObservableObject {
    
    @Published var days : [Day]
    @Published var dayOfWeek: Int
    
    init(dateInWeek: Date) {
        self.days = [Day]()
        dayOfWeek = Calendar.current.component(.weekday, from: dateInWeek) - 1
        
        for i in 0...6 {
            let nextDay = Calendar.current.date(byAdding: .day, value: i - dayOfWeek, to: dateInWeek)
            days.append(Day(date: nextDay!))
        }
    }
}
