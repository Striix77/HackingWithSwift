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

#Preview {
    ContentView()
}
