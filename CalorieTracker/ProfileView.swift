//
//  ProfileView.swift
//  CalorieTracker
//
//  Created by Carlos Zamora on 7/25/22.
//

import SwiftUI
import UIKit


struct ProfileView: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var birthDate = Date()
    @State private var notifications = false
    @State var personProfile: Person
    
    var body: some View {
        NavigationView{
            Form{
                
            Section(header: Text("Personal Information")){
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
                TextField("Email", text: $email)
                DatePicker("Birthdate:", selection: $birthDate, displayedComponents: .date)
                }//end section
                
            Section(header: Text("Actions")){
                Toggle("Notifications", isOn: $notifications)// toggle button
                Link("Article on Daily Calorie Intake",
                     destination: URL(string: "https://health.clevelandclinic.org/how-many-calories-a-day-should-i-eat/")!) //This code will make a text contain a link. It will send you to an article I linked.
            }//end section
            }//end Form
            .navigationTitle("Profile Settings")
            .toolbar{
                ToolbarItemGroup(placement: .navigationBarTrailing){
                    Button("Save", action: saveUser)
                        }
                    }
            .onAppear(perform: {
                firstName = personProfile.firstName
                lastName = personProfile.lastName
                email = personProfile.email
                birthDate = personProfile.birthDate
                notifications = personProfile.receivesNotifications
            })
            //.navigationViewStyle(StackNavigationViewStyle())
        }//end NavView
    }//end var body
    
    func saveUser(){
        personProfile.firstName = firstName
        personProfile.lastName = lastName
        personProfile.email = email
        personProfile.birthDate = birthDate
        personProfile.receivesNotifications = notifications
        
        //idea here is to save the information of the user onto the system.
        print()
        print("----------------------------")
        print("Saved Person Info")
        print("----------------------------")
        
      
       
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(personProfile: Person())
    }
}
