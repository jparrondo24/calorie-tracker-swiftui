//
//  Homepage.swift
//  CalorieTracker
//
//  Created by user220668 on 7/23/22.
//

import SwiftUI

struct Homepage: View {
    @StateObject var week = Week(dateInWeek: Date())
    @State var todaysCalories = 0
    @State var calorieAverage: Double = 0
    
    func calculateCalorieAverage() -> Double {
        var sum = 0
        var numDaysWithMeals = 0
        for day in week.days {
            if day.calorieTotal != 0 {
                numDaysWithMeals += 1
            }
            
            sum += day.calorieTotal
        }
        
        if numDaysWithMeals == 0 {
            return 0
        }
        
        return Double(sum) / Double(numDaysWithMeals)
    }
    
    var body: some View {
        
        NavigationView {
            VStack {
                VStack {
                    Text("Calories count for today")
                    Spacer()
                    Text("\(todaysCalories)")
                        .font(.system(size: 30, weight: .bold))
                }
                .multilineTextAlignment(.center)
                .frame(width: 250.0, height: 50.0)
                
                Spacer()
                VStack {
                    Text("Average daily calorie count for this week")
                    Spacer()
                    Text("\(String(format: "%.2f", calorieAverage))")
                        .font(.system(size: 30, weight: .bold))
                }
                .multilineTextAlignment(.center)
                .frame(width: 250.0, height: 100.0)
                
                Spacer()
                
                VStack {
                    NavigationLink(
                        destination: DaysView(
                            week: week
                        )
                    ) {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 50))
                            .scaleEffect(2.5)
                            .foregroundColor(Color.red)
                    }
                }
                Spacer()
            } //end of VStack
            .onAppear(perform: {
                todaysCalories = week.days[week.dayOfWeek].calorieTotal
                calorieAverage = calculateCalorieAverage()
            })
        } //end of View
    }
    
}

struct Homepage_Previews: PreviewProvider {
    static var previews: some View {
        Homepage()
    }
}
