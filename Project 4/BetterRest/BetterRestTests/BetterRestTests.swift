//
//  BetterRestTests.swift
//  BetterRestTests
//
//  Created by Freak on 20.03.2026.
//

import Testing
@testable import BetterRest
import Foundation

struct BetterRestTests {

    @MainActor
    @Test("Default wake up time is 7am")
    func testDefaultWakeTime() async throws {
        let defaultTime = ContentView.defaultWakeTime
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: defaultTime)
        
        #expect(components.hour == 7)
        #expect(components.minute == 0)
    }
    
    @MainActor
    @Test("CoreML successfully predicts bedtime without throwing an error")
    func testBedtimePrediction() throws {
        let wakeUpTime = ContentView.defaultWakeTime
        let desiredSleep = 8.0
        let coffees = 1
        
        let predictedBedtime = SleepPredictor.calculateBedtime(wakeUp: wakeUpTime, sleepAmount: desiredSleep, coffeeAmount: coffees)
        
        #expect(predictedBedtime != nil)
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: predictedBedtime!)
        #expect(components.hour == 22)
        #expect(components.minute == 38)
    }

}
