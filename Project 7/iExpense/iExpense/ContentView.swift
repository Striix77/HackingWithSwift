//
//  ContentView.swift
//  iExpense
//
//  Created by Freak on 26.03.2026.
//

import SwiftUI

struct ContentView: View {
    @State var viewModel = ExpensesViewModel()
    @State var showingAddExpense = false
    var body: some View {
        NavigationStack {
            ExpensesListView(
                showingAddExpense: $showingAddExpense,
                expenses: viewModel.expenses,
                removeItems: viewModel.removeItems
            )
        }
    }
}

struct ExpensesListView: View {
    @Binding var showingAddExpense: Bool
    let expenses: Expenses
    var removeItems: (IndexSet) -> Void
    var body: some View {
        List {
            ForEach(expenses.items) { item in
                Text(item.name)
            }
            .onDelete(perform: removeItems)
        }
        .navigationTitle("iExpense")
        .toolbar {
            Button("Add expense", systemImage: "plus") {
                showingAddExpense = true
            }
        }
        .sheet(isPresented: $showingAddExpense) {
            AddView(expenses: expenses)
        }
    }

}

#Preview {
    ContentView()
}
