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

struct DaysView: View {
    @StateObject var week: Week
    @StateObject var list: List = List()
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
                    Spacer()
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
                dayToAddTo: week.days[selection],
                saveMeal: list
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

//has to show saved meals from List
//The rows must be able to be selected
//Must have popup with Y/N
//Yes puts saved meal in the Day class
//After add exit view and go back to Day/Week view
//No gets rid of popup and goes back to the normal view
/*struct FoodView: View {
    @StateObject var list: List = List()
    
    var body: some View {
        ForEach(list.meals) {
            //print(meal)
        }
    }
}*/

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
    @State var saveMeal: List
    
    @State private var name: String = ""
    @State private var description: String = ""
    @State private var calorieCount: Int = 0
    
    var body: some View {
        MealFormView(
            name: $name,
            description: $description,
            calorieCount: $calorieCount,
            onSubmitAttemptSave: {
                //add to saved meals array
                dayToAddTo.addMeal(meal: Meal(name: name, description: description, calorieCount: calorieCount))
                presentationMode.wrappedValue.dismiss()
            },
            onSubmitAttemptAdd: {
                dayToAddTo.addMeal(meal: Meal(name: name, description: description, calorieCount: calorieCount))
                presentationMode.wrappedValue.dismiss()
            },
            pullList: "Use Saved Meal",
            option1: "Save Meal",
            option2: "Add Meal"
        )
    }
}


/*struct useSavedMealView: View {
    //Shows drop down menu of meals listed in alphabetical order
    //once the meal is selected pop up happens
    //Add meal? Yes or no button
    //if yes
        dayToAddTo.addMeal(meal: Meal(name: name, description: description, calorieCount: calorieCount))
        //exit View
    //else
        //delete popup, go back to meal listing
}*/


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
            onSubmitAttemptAdd: {
                mealToEdit.name = name
                mealToEdit.description = description
                mealToEdit.calorieCount = calorieCount
                presentationMode.wrappedValue.dismiss()
            },
            option2: "Save Meal"
        )
    }
}

//if useSavedItem is enabled must use struct FoodView
struct MealFormView: View {
    @Binding var name: String
    @Binding var description: String
    @Binding var calorieCount: Int
    @State var useSavedItem: (() -> Void)?
    @State var onSubmitAttemptSave: (() -> Void)?
    @State var onSubmitAttemptAdd: () -> Void
    @State var pullList: String?
    @State var option1: String?
    @State var option2: String
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 30) {
                    if useSavedItem != nil {
                        Button(action: useSavedItem ?? {}) {
                            Text("\(pullList ?? "")")
                                .foregroundColor(Color.white)
                                .padding(.vertical, 12)
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(12)
                            .padding(.bottom, 30)
                        }
                    }
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
            //.frame(maxWidth: .infinity, maxHeight: .infinity)
            if onSubmitAttemptSave != nil {
                Button(action: onSubmitAttemptSave ?? {}) {
                    Text("\(option1 ?? "")")
                        .foregroundColor(Color.white)
                        .padding(.vertical, 12)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(12)
                    .padding(.bottom, 30)
                }
            }
            
            Button(action: onSubmitAttemptAdd) {
                Text("\(option2)")
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
