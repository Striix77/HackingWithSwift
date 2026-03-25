//
//  SleepPredictor.swift
//  BetterRest
//
//  Created by Freak on 25.03.2026.
//
import Foundation
import CoreML

struct SleepPredictor {
    static func calculateBedtime(wakeUp: Date, sleepAmount:Double, coffeeAmount:Int) -> Date?{
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
}
