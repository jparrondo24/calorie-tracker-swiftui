//
//  Homepage.swift
//  CalorieTracker
//
//  Created by user220668 on 7/23/22.
//

import SwiftUI

struct Homepage: View {
    var body: some View {
        
        NavigationView {
            VStack {
                VStack {
                    Text("Calories count for today")
                        .multilineTextAlignment(.center)
                        .frame(width: 250.0, height: 50.0)
                }
                Spacer()
                VStack {
                    Text("Average daily calorie count for this week")
                        .multilineTextAlignment(.center)
                        .frame(width: 250.0, height: 100.0)
                }
                Spacer()
                
                VStack {
                    NavigationLink(destination: ContentView()) {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 50))
                            .scaleEffect(2.5)
                            .foregroundColor(Color.red)
                    }
                }
                Spacer()
            } //end of VStack

        } //end of View
    }
    
}

struct Homepage_Previews: PreviewProvider {
    static var previews: some View {
        Homepage()
    }
}
