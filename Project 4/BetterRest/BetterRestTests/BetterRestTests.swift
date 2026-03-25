//
//  BetterRestTests.swift
//  BetterRestTests
//
//  Created by Freak on 20.03.2026.
//

import Testing
@testable import BetterRest

struct BetterRestTests {

    @MainActor
    @Test("Default wake up time is 7am")
    func testDefaultWakeTime() async throws {
        let defaultTime = ContentView.defaultWakeTime
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: defaultTime)
        
        #expect(components.hour == 7)
        #expect(components.minute == 0)
    }
    }

}
