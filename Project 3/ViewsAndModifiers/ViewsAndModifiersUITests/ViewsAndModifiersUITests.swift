//
//  ViewsAndModifiersUITests.swift
//  ViewsAndModifiersUITests
//
//  Created by Freak on 17.03.2026.
//

import XCTest

final class ViewsAndModifiersUITests: XCTestCase {

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
    func testColorButtonTogglesWithoutCrashing() throws {
        let app = XCUIApplication()
        app.launch()
        
        let toggleButton = app.buttons["ColorChangingButton"]
        
        XCTAssertTrue(toggleButton.exists, "The toggle button should be visible.")
        
        toggleButton.tap()
        
        toggleButton.tap()
    }
    
    @MainActor
    func testGryffindorIsVisible() throws {
        let app = XCUIApplication()
        app.launch()
        
        let gryffindorText = app.staticTexts["Gryffindor"]
        
        XCTAssertTrue(gryffindorText.exists, "Gryffindor should be on the screen!")
        
        
    }
    
    @MainActor
    func testAppCanScrollToBottom() throws {
        let app = XCUIApplication()
        app.launch()
        
        let bottomElement = app.descendants(matching: .any)["Watermark"]
        
        var swipeCount = 0
        while !bottomElement.isHittable && swipeCount < 5 {
            app.swipeUp()
            swipeCount += 1
        }
        
        XCTAssertTrue(bottomElement.isHittable, "User should be able to scroll to the bottom of the app!")
    }
    
    @MainActor
    func testGlobeIconLoads() throws {
        let app = XCUIApplication()
        app.launch()
        
        let globeImage = app.images["globe"]
        
        XCTAssertTrue(globeImage.exists, "The globe icon should be displayed in the welcome section!")
    }

    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
