//
//  food.swift
//  CalorieTracker
//
//  Created by Justin Montes De Oca on 7/27/22.
//

import Foundation
import UIKit
import SwiftUI


struct tacoBellList: Identifiable {
    var id = UUID()
    var name: String
    var calories: String
    
}

struct mcdonaldsList: Identifiable {
    var id = UUID()
    var name: String
    var calories: String
    
}

struct KFCList: Identifiable {
    var id = UUID()
    var name: String
    var calories: String
    
}

struct chickfilalist: Identifiable {
    var id = UUID()
    var name: String
    var calories: String
    
}




struct food: View {
    
    var body: some View {
        
            VStack(alignment: .leading){
                NavigationLink(
                    destination: tacoBell()){
                        Text("Taco Bell")
                            .bold()
                            .frame(width: 100,height: 100)
                        
                    }
                
                
                    NavigationLink(
                        destination: mcdonalds()){
                            Text("Mcdonalds")
                                .bold()
                                .frame(width: 100,height: 100)
                            
                        }
                
                NavigationLink(
                    destination: KFC()){
                        Text("KFC")
                            .bold()
                            .frame(width: 100,height: 100)
                        
                    }
                
                NavigationLink(
                    destination: chickfila()){
                        Text("Chick-fil-a")
                            .bold()
                            .frame(width: 100,height: 100)
                        
                    }
                
                    Spacer()
                
            }// vstack
        // hstack
    }// body
}// view

struct tacoBell: View {
    let list = [
        tacoBellList(name: "beefy melt burrito", calories: "620"),
        tacoBellList(name: "spicy potatoe soft taco", calories: "230"),
        tacoBellList(name: "mexican pizza ", calories: "550"),
        tacoBellList(name: "cheesy bean and rice burrito ", calories: "420"),
        tacoBellList(name: "classic cheesy double beef burrito ", calories: "620"),
    ]
    
    
    
    var body: some View {
        
        List(list){ food in
            VStack(alignment: .leading){
                Text(food.name)
                Text(food.calories)
                
            }
            }// vstack
        }// hstack
    }// body
// view


struct mcdonalds: View {
    let list = [
        mcdonaldsList(name: "double cheeseburger", calories: "450"),
        mcdonaldsList(name: "quater punder with chees", calories: "520"),
        mcdonaldsList(name: "spicy chicken sandwhich", calories: "530"),
        mcdonaldsList(name: "big mac", calories: "550"),
        mcdonaldsList(name: "mcdouble", calories: "400"),
    ]
    
    
    
    var body: some View {
        
        List(list){ food in
            VStack(alignment: .leading){
                Text(food.name)
                Text(food.calories)
                
                
            }// vstack
        }// hstack
    }// body
}// view

struct KFC: View {
    let list = [
        KFCList(name: "original recipe chicken breast", calories: "390"),
        KFCList(name: "kentucky grilled chicken breast", calories: "210"),
        KFCList(name: "chicekn littles", calories: "300"),
        KFCList(name: "chicken pot pie", calories: "720"),
        KFCList(name: "KFC famous bowl", calories: "740"),
    ]
    
    
    
    var body: some View {
        
        List(list){ food in
            VStack(alignment: .leading){
                Text(food.name)
                Text(food.calories)
                
                
            }// vstack
        }// hstack
    }// body
}// view


struct chickfila: View {
    let list = [
        chickfilalist(name: "spicy deluxe sandwich", calories: "550"),
        chickfilalist(name: "grilled nuggets", calories: "130"),
        chickfilalist(name: "chick-fil-a cool wrap", calories: "660"),
        chickfilalist(name: "chick-fil-a nuggets", calories: "250"),
        chickfilalist(name: "grilled chicken sandwhich", calories: "380"),
    ]
    
   
    
    var body: some View {
        
        List(list){ food in
            VStack(alignment: .leading){
                Text(food.name)
                Text(food.calories)
                
                
            }// vstack
        }// hstack
    }// body
}// view

func addMeal()->Void {
   
}

struct food_Previews: PreviewProvider {
    static var previews: some View {
        food()
    }
}
    
    struct tacoBell_Previews: PreviewProvider {
        static var previews: some View {
            tacoBell()
            
        }
}
