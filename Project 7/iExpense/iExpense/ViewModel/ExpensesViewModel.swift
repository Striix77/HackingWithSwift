//
//  ExpensesViewModel.swift
//  iExpense
//
//  Created by Freak on 26.03.2026.
//
import SwiftUI

@Observable
class ExpensesViewModel {
    private(set) var expenses = Expenses()
    
    func removeItems(at offsets: IndexSet){
        expenses.items.remove(atOffsets: offsets)
    }
}
