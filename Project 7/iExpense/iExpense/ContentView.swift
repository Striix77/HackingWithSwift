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

#Preview {
    ContentView()
}
