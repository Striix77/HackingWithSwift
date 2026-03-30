//
//  AnimationsUITests.swift
//  AnimationsUITests
//
//  Created by Freak on 25.03.2026.
//

import XCTest

final class AnimationsUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testToggleRedRectangle() throws {
        let app = XCUIApplication()
        app.launch()

        let toggleRedButton = app.buttons["ToggleRedButton"]
        let redRectangle = app.otherElements["RedRectangle"]

        XCTAssertFalse(redRectangle.exists)

        toggleRedButton.tap()

        XCTAssertTrue(redRectangle.waitForExistence(timeout: 2))
    }

    @MainActor
    func testSpinningButtonRemainsHittable() {
        let app = XCUIApplication()
        app.launch()

        let spinButton = app.buttons["Spin Me"]
        XCTAssertTrue(spinButton.exists)
        
        spinButton.tap()
        spinButton.tap()

        XCTAssertTrue(spinButton.isHittable)
    }
    
    @MainActor
    func testDraggableGradientReset() {
        let app = XCUIApplication()
        app.launch()
        
        let gradient = app.scrollViews.otherElements["DraggableGradient"]
        
        while !gradient.isHittable {
            app.swipeUp()
        }
        
        let initialFrame = gradient.frame
        
        let start = gradient.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
        let end = gradient.coordinate(withNormalizedOffset: CGVector(dx: 0.9, dy: 0.9))
        
        start.press(forDuration: 0.1, thenDragTo: end)
        
        XCTAssertTrue(gradient.exists, "The gradient should still exist.")

        _ = XCTWaiter.wait(for: [XCTestExpectation(description: "Wait for animation")], timeout: 2)
        
        let finalFrame = gradient.frame
        
        XCTAssertEqual([initialFrame.origin.x,initialFrame.origin.y], [finalFrame.origin.x,finalFrame.origin.y], "The gradient should return to its original coordinates.")
    }

    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
