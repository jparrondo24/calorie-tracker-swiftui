//
//  Person.swift
//  CalorieTracker
//
//  Created by Carlos Zamora on 7/25/22.
//

import Foundation

class Person: ObservableObject {
    
    @Published var firstName: String
    @Published var lastName: String
    @Published var email: String
    @Published var birthDate: Date
    @Published var receivesNotifications: Bool
    
    init() {
        firstName = ""
        lastName = ""
        email = ""
        birthDate = Date()
        receivesNotifications = false
    }
    
    init(firstName:String, lastName: String, email: String, birthDate: Date, receivesNotifications: Bool){
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.birthDate = birthDate
        self.receivesNotifications = receivesNotifications
    }//this initializer creates an object Person
    
    
}
