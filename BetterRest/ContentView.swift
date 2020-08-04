//
//  ContentView.swift
//  BetterRest
//
//  Created by Toan Le on 8/4/20.
//  Copyright © 2020 TL. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 0.0
    @State private var coffeeAmount = 1
    @State private var wakeUp = Date()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10){
                Text("When do you want to wake up?")
                    .font(.headline)
                
                DatePicker("Wake up time",selection:  $wakeUp, in: Date()..., displayedComponents: .hourAndMinute)
                .labelsHidden()
                
                Text("How much sleep do you want?")
                Stepper(value: $sleepAmount, in: 4...9, step: 0.25) {
                    Text("\(sleepAmount, specifier: "%.2f") hours")
                }
                
                Text("How much coffee do you drink per day?")
                Stepper(value: $coffeeAmount, in: 1...10) {
                    if coffeeAmount > 1 {
                        Text("\(coffeeAmount) cups")
                    } else {
                        Text("1 cup")
                    }
                }
                
                Spacer()
            }
            .navigationBarTitle("Better Rest")
            .navigationBarItems(trailing:
                Button(action: calculateBedtime) {
                    Text("Calculate Bedtime")
                }
            )
        }
    }
    
    func calculateBedtime() {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
    
