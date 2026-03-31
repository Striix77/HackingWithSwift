//
//  iExpenseTests.swift
//  iExpenseTests
//
//  Created by Freak on 26.03.2026.
//

import Testing

@testable import iExpense

struct iExpenseTests {

    @MainActor
    @Test("Adding new expenses should increment count")
    func testAddingExpenseIncrementsCount() async throws {
        let expenses = Expenses()
        let initialCount = expenses.items.count
        let newItem = ExpenseItem(name: "Test", type: "Personal", amount: 100, currency: "USD")
        
        expenses.items.append(newItem)
        
        #expect(expenses.items.count == initialCount + 1)
        #expect(expenses.items.last?.name == "Test")
    }
    
    @MainActor
    @Test("Deleting expenses should decrement count")
    func testDeletingExpense() async throws {
        let expenses = Expenses()
        let initialCount = expenses.items.count
        let newItem = ExpenseItem(name: "Test", type: "Personal", amount: 100, currency: "USD")
        
        expenses.items.append(newItem)
        expenses.items.removeLast()
        
        #expect(expenses.items.count == initialCount)
    }

}
