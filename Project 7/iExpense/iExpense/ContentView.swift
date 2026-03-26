//
//  ContentView.swift
//  iExpense
//
//  Created by Freak on 26.03.2026.
//

import SwiftUI

struct ContentView: View {
    @State private var expenses = Expenses()
    var body: some View {
        NavigationStack{
            ExpensesListView(expenses:expenses)
        }
    }
}

struct ExpensesListView: View {
    let expenses: Expenses
    var body: some View {
        List {
            ForEach(expenses.items, id:\.name ){ item in
                Text(item.name)
            }
        }
        .navigationTitle("iExpense")
    }
}

#Preview {
    ContentView()
}
