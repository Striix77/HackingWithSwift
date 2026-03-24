//
//  ViewsAndModifiersTests.swift
//  ViewsAndModifiersTests
//
//  Created by Freak on 17.03.2026.
//

import Testing
@testable import ViewsAndModifiers

struct ViewsAndModifiersTests {

    @Test("CapsuleText correctly stores its display text")
        func capsuleTextInitialization() async throws {
            let expectedText = "Capsule test"
            
            let capsule = CapsuleText(text: expectedText)
            
            #expect(capsule.text == expectedText)
        }

}
