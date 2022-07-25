//
//  Day.swift
//  CalorieTracker
//
//  Created by Justin Parrondo on 7/19/22.
//

import Foundation

class Day: Identifiable, ObservableObject {
    
    @Published var date: Date
    @Published var dateString: String
    @Published var meals: [Meal]
    @Published var calorieTotal: Int
    
    init(date: Date) {
        self.date = date
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd"
        dateString = formatter.string(from: date)
        
        meals = [Meal]()
        calorieTotal = 0
    }
    
    func addMeal(meal: Meal) {
        meals.append(meal)
        calorieTotal += meal.calorieCount
    }
    
    func removeMeal(meal: Meal) {
        calorieTotal -= meal.calorieCount
        meals.remove(at: meals.firstIndex(of: meal) ?? 0)
    }
    
    func fillMealsWithDummies() {
        meals.append(Meal(name: "Breakfast", description: "Tacos", calorieCount: 400))
        meals.append(Meal(name: "Lunch", description: "McDonalds Quarter Pounder", calorieCount: 700))
        meals.append(Meal(name: "Dinner", description: "Pan con Lechon", calorieCount: 500))
    }
}
