//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Freak on 26.03.2026.
//
import Foundation

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet{
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
}

