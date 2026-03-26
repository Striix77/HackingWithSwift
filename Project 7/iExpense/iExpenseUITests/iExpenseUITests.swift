//
//  iExpenseUITests.swift
//  iExpenseUITests
//
//  Created by Freak on 26.03.2026.
//

import XCTest

final class iExpenseUITests: XCTestCase {

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
    func testAddingNewExpenseUpdatesList() throws {
        let app = XCUIApplication()
        app.launch()

        let addButton = app.buttons["Add expense"]
        XCTAssertTrue(addButton.exists)
        addButton.tap()
        
        let nameField = app.textFields["NameTextField"]
        XCTAssertTrue(nameField.exists)
        nameField.tap()
        nameField.typeText("New Headphones")
        
        let amountField = app.textFields["AmountTextField"]
        XCTAssertTrue(amountField.exists)
        amountField.tap()
        amountField.typeText("150")
        
        let saveButton = app.buttons["Save"]
        XCTAssertTrue(saveButton.exists)
        saveButton.tap()
        
        let newList = app.collectionViews["ExpansesList"]
        let newRow = newList.cells.staticTexts["New Headphones"]
        
        XCTAssertTrue(newRow.waitForExistence(timeout: 2.0), "The new expense should appear in the list.")
    }

    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
