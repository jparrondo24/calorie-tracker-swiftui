//
//  ContentView.swift
//  CalorieTracker
//
//  Created by Justin Parrondo on 7/19/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Homepage()
    }
    
}

//return the totalDaily to the Homepage
/*struct totalDaily: Int {
    return currentCalorieTotal
}*/

struct DaysView: View {
    @StateObject var week: Week
    @State var selection: Int
    @State var currentCalorieTotal: Int
    @State var showSheet: Bool
    let weekdays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    
    init(week: Week) {
        _week = StateObject(wrappedValue: week)
        selection = week.dayOfWeek
        currentCalorieTotal = week.days[week.dayOfWeek].meals.reduce(0) { $0 + $1.calorieCount }
        showSheet = false
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                HStack {
                    Text("\(weekdays[selection])," + "\n" + "\(week.days[selection].dateString)")
                        .font(.system(size: 30, weight: .bold))
                        .lineLimit(2)
                    NavigationLink(
                        destination: food()){
                            Text("foods")
                                .bold()
                                .frame(width: 70,height: 10)
                                
                            
                            
                        }.padding()
                    Button(action: { showSheet = true }) {
                        Image(systemName: "plus")
                            .foregroundColor(Color.black)
                    }
                }
                .padding(.bottom, 2.5)
                Text("Total: " + "\(currentCalorieTotal)")
                    .font(.system(size: 18, weight: .bold))
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 3)
            
            TabView(selection: $selection) {
                ForEach(0..<7) { i in
                    DayView (
                        day: week.days[i],
                        currentCalorieTotal: $currentCalorieTotal
                    )
                    .tag(i)
                }
            }
            .tabViewStyle(.page)
            .onChange(of: selection, perform: { index in
                currentCalorieTotal = week.days[selection].meals.reduce(0) { $0 + $1.calorieCount }
            })
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Color"))
        .sheet(isPresented: $showSheet, onDismiss: {
            currentCalorieTotal = week.days[selection].meals.reduce(0) { $0 + $1.calorieCount }
        }, content: {
            AddMealSheetView(
                dayToAddTo: week.days[selection]
            )
        })
    }
}

struct DayView: View {
    @StateObject var day: Day
    @Binding var currentCalorieTotal: Int
    
    var body: some View {
        ScrollView {
            VStack {
                if day.meals.isEmpty {
                    VStack {
                        Text("No Meals Added")
                            .fontWeight(.bold)
                            .font(.system(size: 25, weight: .bold))
                            .padding(.vertical, 15)
                        Text("Press the '+' in the top right corner to get started!")
                        
                    }
                    .frame(maxWidth: .infinity, minHeight: 170, maxHeight: 170, alignment: .top)
                    .background(Color.white)
                    .cornerRadius(12)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                } else {
                    ForEach(day.meals) { meal in
                        MealView(
                            meal: meal,
                            deleteMeal: {
                                day.removeMeal(meal: meal)
                                currentCalorieTotal -= meal.calorieCount
                            },
                            onEditSubmit: {
                                currentCalorieTotal = day.meals.reduce(0) { $0 + $1.calorieCount }
                                day.calorieTotal = currentCalorieTotal
                            }
                        )
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.bottom, 50)
    }
}

struct MealView: View {
    @StateObject var meal: Meal
    @State var deleteMeal: () -> Void
    @State var onEditSubmit: () -> Void
    
    @State var showSheet = false
    
    func editMeal() {
        showSheet = true
    }
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(meal.name)
                        .fontWeight(.bold)
                        .font(.system(size: 25, weight: .bold))
                        .padding(.bottom, 0.125)
                    Text(meal.description)
                    Spacer()
                }
                .frame(maxHeight: .infinity)
                .padding(15)
                
                Spacer()
                Text("\(meal.calorieCount)")
                    .padding(15)
                    .font(.system(size: 18, weight: .bold))
            }
            HStack {
                Button(action: editMeal) {
                    HStack {
                        Spacer()
                        Image(systemName: "pencil")
                            .foregroundColor(Color(.white))
                        Spacer()
                    }
                    .frame(maxHeight: .infinity)
                    .background(Color.blue)
                }
                
                Button(action: deleteMeal) {
                    HStack {
                        Spacer()
                        Image(systemName: "trash")
                            .foregroundColor(Color(.white))
                        Spacer()
                    }
                }
                .frame(maxHeight: .infinity)
                .background(Color.red)
            }
            .frame(maxWidth: .infinity, minHeight: 35, maxHeight: 35)
        }
        .frame(maxWidth: .infinity, minHeight: 170, maxHeight: 170)
        .background(Color.white)
        .cornerRadius(12)
        .padding(.horizontal, 20)
        .padding(.vertical, 5)
        .sheet(isPresented: $showSheet, onDismiss: onEditSubmit, content: {
            EditMealSheetView(mealToEdit: meal)
        })
        
    }
}


struct AddMealSheetView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var dayToAddTo: Day
    
    @State private var name: String = ""
    @State private var description: String = ""
    @State private var calorieCount: Int = 0
    
    var body: some View {
        MealFormView(
            name: $name,
            description: $description,
            calorieCount: $calorieCount,
            onSubmitAttempt: {
                dayToAddTo.addMeal(meal: Meal(name: name, description: description, calorieCount: calorieCount))
                presentationMode.wrappedValue.dismiss()
            },
            buttonText: "Add Meal"
        )
    }
}


struct EditMealSheetView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var mealToEdit: Meal
    @State var name: String
    @State var description: String
    @State var calorieCount: Int
    
    init(mealToEdit: Meal) {
        _mealToEdit = State(wrappedValue: mealToEdit)
        _name = State(initialValue: mealToEdit.name)
        _description = State(initialValue: mealToEdit.description)
        _calorieCount = State(initialValue: mealToEdit.calorieCount)
    }
    
    var body: some View {
        MealFormView(
            name: $name,
            description: $description,
            calorieCount: $calorieCount,
            onSubmitAttempt: {
                mealToEdit.name = name
                mealToEdit.description = description
                mealToEdit.calorieCount = calorieCount
                presentationMode.wrappedValue.dismiss()
            },
            buttonText: "Save Meal"
        )
    }
}


struct MealFormView: View {
    @Binding var name: String
    @Binding var description: String
    @Binding var calorieCount: Int
    @State var onSubmitAttempt: () -> Void
    @State var buttonText: String
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 30) {
                    VStack {
                        HStack {
                            Text("Name")
                                .font(.system(size: 22, weight: .bold))
                            Spacer()
                        }
                        TextField(
                            "",
                            text: $name
                        )
                        .textFieldStyle(.roundedBorder)
                    }
                    VStack {
                        HStack {
                            Text("Description")
                                .font(.system(size: 22, weight: .bold))
                            Spacer()
                        }
                        TextField(
                            "",
                            text: $description
                        )
                        .textFieldStyle(.roundedBorder)
                    }
                    VStack {
                        HStack {
                            Text("Calories")
                                .font(.system(size: 22, weight: .bold))
                            Spacer()
                        }
                        TextField(
                            "",
                            value: $calorieCount,
                            format: .number
                        )
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.numberPad)
                    }
                    
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            Button(action: onSubmitAttempt) {
                Text("\(buttonText)")
                    .foregroundColor(Color.white)
                    .padding(.vertical, 12)
            }
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .cornerRadius(12)
            .padding(.bottom, 30)
        }
        .padding(.horizontal, 20)
        .padding(.top, 30)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
