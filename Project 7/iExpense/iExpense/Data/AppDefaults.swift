//
//  AppStrings.swift
//  iExpense
//
//  Created by Freak on 30.03.2026.
//
import Foundation

struct AppDefaults {
    static let navigationTitle = "iExpense"
    static let expensesTitle = "Add new expense"
    static let addExpansesButton = "Add Expense"
    static let namePlaceholder = "Name"
    static let amountPlaceholder = "Amount"
    static let typeLabel = "Type"
    static let filterLabel = "Filter"
    static let saveButton = "Save"
    static let defaultAmount = 0.0
    
    
    static let defaultType = "Personal"
    static let defaultCurrency = "USD"
    
    
    static let expenseTypes = ["Business", "Personal"]
    
    static let nameAccessibilityID = "NameTextField"
    static let amountAccessibilityID = "AmountTextField"
    static let expansesAccessibilityID = "ExpansesList"
    
    static let expenseTypesFilters = ["All", "Personal", "Business"]
}
