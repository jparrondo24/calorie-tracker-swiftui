//
//  List.swift
//  CalorieTracker
//
//  Created by user220668 on 7/26/22.
//

import Foundation

class List: Identifiable, ObservableObject {
    @Published var meals: [Meal]
    
    init() {
        meals = [Meal]()
    }
    
    func addMeal(meal: Meal) {
        meals.append(meal)
    }
    
    func fillMealsWithDummies() {
        meals.append(Meal(name: "Breakfast", description: "Tacos", calorieCount: 400))
        meals.append(Meal(name: "Lunch", description: "McDonalds Quarter Pounder", calorieCount: 700))
        meals.append(Meal(name: "Dinner", description: "Pan con Lechon", calorieCount: 500))
    }
}

