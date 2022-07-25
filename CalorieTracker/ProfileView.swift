//
//  ProfileView.swift
//  CalorieTracker
//
//  Created by Carlos Zamora on 7/25/22.
//

import SwiftUI

struct ProfileView: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var birthDate = Date()
    @State private var notifications = false
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
            .navigationTitle("Profile")
            .toolbar{
                ToolbarItemGroup(placement: .navigationBarTrailing){
                    Button("Save", action: saveUser)
                        }
                    }
            .navigationViewStyle(StackNavigationViewStyle())
        }//end NavView
    }//end var body
    
    func saveUser(){
        print("User saved")
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
