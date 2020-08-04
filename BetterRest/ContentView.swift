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
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10){
                Text("When do you want to wake up?")
                    .font(.headline)
                
                DatePicker("Wake up time",selection:  $wakeUp, displayedComponents: .hourAndMinute)
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
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func calculateBedtime() {
        let model = SleepCalculator()
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: Double(sleepAmount), coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            let formarter = DateFormatter()
            formarter.timeStyle = .short
            alertTitle = "You should go to sleep at..."
            alertMessage = formarter.string(from: sleepTime)
        } catch {
            alertTitle = "Error"
            alertTitle = "There was a problem calculating your sleep time."
        }
        showingAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
    
