//
//  Meal.swift
//  CalorieTracker
//
//  Created by Justin Parrondo on 7/19/22.
//

import Foundation

class Meal: Identifiable, ObservableObject, Equatable {
    static func == (lhs: Meal, rhs: Meal) -> Bool {
        return lhs.id == rhs.id
    }
    
    
    @Published var name: String
    @Published var description: String
    @Published var calorieCount: Int
    
    init(name: String, description: String, calorieCount: Int) {
        self.name = name
        self.description = description
        self.calorieCount = calorieCount
    }
}
