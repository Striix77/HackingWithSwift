//
//  ContentView.swift
//  BetterRest
//
//  Created by Freak on 20.03.2026.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount: Double = 8.0
    @State private var wakeUp = Date.now

    let components = Calendar.current.dateComponents(
        [.hour, .minute],
        from: Date.now
    )
    var hour: Int { components.hour ?? 0 }
    var minute: Int { components.minute ?? 0 }

    var body: some View {
        VStack {
            Stepper(
                "\(sleepAmount.formatted()) hours",
                value: $sleepAmount,
                in: 0...16,
                step: 0.25
            )
            DatePicker("Please enter a date", selection: $wakeUp)
                .labelsHidden()
            DatePicker(
                "Please enter a date",
                selection: $wakeUp,
                displayedComponents: .hourAndMinute
            )
            .labelsHidden()
            DatePicker(
                "Please enter a date",
                selection: $wakeUp,
                in: Date.now...
            )
            Text(Date.now, format: .dateTime.hour().minute())
            Text(Date.now, format: .dateTime.day().month().year())
            Text(Date.now.formatted(date: .long, time: .shortened))
        }
        .padding()
    }
}

//func exampleDates() {
//    let tomorrow = Date.now.addingTimeInterval(86400)
//    let range = Date.now...tomorrow
//}

#Preview {
    ContentView()
}
