//
//  ContentView.swift
//  iExpense
//
//  Created by Freak on 26.03.2026.
//

import SwiftUI

struct ContentView: View {
    @State var viewModel = ExpensesViewModel()
    var body: some View {
        NavigationStack {
            ExpensesListView(
                expenses: viewModel.expenses,
                removeItems: viewModel.removeItems
            )
        }
    }
}

struct ExpensesListView: View {
    let expenses: Expenses
    var removeItems: (IndexSet) -> Void
    var body: some View {
        List {
            ForEach(expenses.items, id: \.name) { item in
                Text(item.name)
            }
            .onDelete(perform: removeItems)
        }
        .navigationTitle("iExpense")
        .toolbar {
            Button("Add expense", systemImage: "plus") {
                let expense = ExpenseItem(
                    name: "Test",
                    type: "Personal",
                    amount: 5
                )
                expenses.items.append(expense)
            }
        }
    }

}

#Preview {
    ContentView()
}
