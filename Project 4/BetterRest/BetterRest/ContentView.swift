//
//  ContentView.swift
//  BetterRest
//
//  Created by Freak on 20.03.2026.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1

    init() {
        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Form {
                    WakeUpTimePickerView(wakeUp: $wakeUp)
                    DesiredSleepStepperView(sleepAmount: $sleepAmount)
                    DailyCoffeeIntakePickerView(coffeeAmount: $coffeeAmount)
                    IdealBedtimeView(idealSleepAmount: idealSleepAmount)
                        .listRowBackground(
                            Color(
                                red: 0.2,
                                green: 0.6,
                                blue: 1,
                                opacity: 0.20
                            )
                        )

                }
                .scrollContentBackground(.hidden)
                .background(
                    RadialGradient(
                        colors: [
                            Color(
                                red: 0,
                                green: 0.25,
                                blue: 0.5,
                                opacity: 1
                            ), Color.black,
                        ],
                        center: UnitPoint(x: 0.90, y: 0.8),
                        startRadius: 10,
                        endRadius: 900
                    )
                    .ignoresSafeArea()
                )
            }
            .navigationTitle("BetterRest")

        }
        .foregroundStyle(Color.white)
    }

    private var idealSleepAmount: Date? {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)

            let components = Calendar.current.dateComponents(
                [.hour, .minute],
                from: wakeUp
            )
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60

            let prediction = try model.prediction(
                wake: Double(hour + minute),
                estimatedSleep: sleepAmount,
                coffee: Double(coffeeAmount)
            )

            let sleepTime = wakeUp - prediction.actualSleep

            return sleepTime
        } catch {
            return nil
        }
    }

    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }

}

struct WakeUpTimePickerView: View {
    @Binding var wakeUp: Date
    var body: some View {
        Section(
            header: Text("When do you want to wake up?")
                .font(.headline)
        ) {

            DatePicker(
                "Please enter a time",
                selection: $wakeUp,
                displayedComponents: .hourAndMinute
            )
            .labelsHidden()
            .environment(\.colorScheme, .dark)
            .listRowBackground(
                Color(
                    red: 0.2,
                    green: 0.6,
                    blue: 1,
                    opacity: 0.15
                )
            )

        }
    }
}

struct DesiredSleepStepperView: View {
    @Binding var sleepAmount: Double
    var body: some View {
        Section(
            header: Text("Desired amount of sleep")
                .font(.headline)
        ) {
            Stepper(
                "\(sleepAmount.formatted()) hours",
                value: $sleepAmount,
                in: 4...12,
                step: 0.25
            )
            .listRowBackground(
                Color(
                    red: 0.2,
                    green: 0.6,
                    blue: 1,
                    opacity: 0.15
                )
            )
        }
    }
}

struct DailyCoffeeIntakePickerView: View {
    @Binding var coffeeAmount: Int
    var body: some View {
        Section(
            header: Text("Daily coffee intake")
                .font(.headline)
        ) {
            Picker("Number of cups", selection: $coffeeAmount) {
                ForEach(0..<21) { amount in
                    Text("^[\(amount) cup](inflect:true)")
                }
            }
            .environment(\.colorScheme, .dark)
            .listRowBackground(
                Color(
                    red: 0.2,
                    green: 0.6,
                    blue: 1,
                    opacity: 0.15
                )
            )
        }
    }
}

struct IdealBedtimeView: View {
    let idealSleepAmount: Date?
    var body: some View {
        Section(
            header: HStack {
                Spacer()
                Text("Your ideal bedtime is...")
                Spacer()
            }
        ) {
            HStack {
                Spacer()
                Text(
                    idealSleepAmount?.formatted(
                        date: .omitted,
                        time: .shortened
                    ) ?? "NaN"
                )
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
}
