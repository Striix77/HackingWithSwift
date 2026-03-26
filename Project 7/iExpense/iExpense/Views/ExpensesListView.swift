//
//  ExpensesListView.swift
//  iExpense
//
//  Created by Freak on 26.03.2026.
//
import SwiftUI

struct ExpensesListView: View {
    @Binding var showingAddExpense: Bool
    let expenses: Expenses
    var removeItems: (IndexSet) -> Void
    var body: some View {
        List {
            ForEach(expenses.items) { item in
                HStack{
                    VStack(alignment: .leading){
                        Text(item.name)
                            .font(.headline)
                        
                        Text(item.type)
                    }
                    Spacer()
                    Text(item.amount, format: .currency(code: item.currency))
                        .foregroundStyle(
                            item.amount < 10 ? .green : (item.amount < 100 ? .primary : .red)
                        )
                }
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

