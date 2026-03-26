//
//  ExpensesListView.swift
//  iExpense
//
//  Created by Freak on 26.03.2026.
//
import SwiftUI

struct ExpensesListView: View {
    @Binding var showingAddExpense: Bool
    @State var expenseType = ""
    
    let expenses: Expenses
    var removeItems: (IndexSet) -> Void
    var expenseTypes = ["All", "Personal", "Business"]
    
    var filteredExpenses: [ExpenseItem] {
        if expenseType == "" || expenseType == "All" {
            return expenses.items
        }
        return expenses.items.filter{
            $0.type == expenseType
        }
    }
    
    var body: some View {
        List {
            ForEach(filteredExpenses) { item in
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.headline)

                        Text(item.type)
                    }
                    Spacer()
                    Text(item.amount, format: .currency(code: item.currency))
                        .foregroundStyle(
                            item.amount < 10
                                ? .green : (item.amount < 100 ? .primary : .red)
                        )
                }
                .accessibilityIdentifier("Expense item_\(item.name)")
            }
            .onDelete(perform: removeItems)
        }
        .accessibilityIdentifier("ExpansesList")
        .navigationTitle("iExpense")
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Button("Add expense", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
            
            ToolbarItem(placement:.topBarTrailing) {
                Menu{
                    Picker("", selection:$expenseType){
                        ForEach(expenseTypes, id: \.self) {
                            Text($0)
                        }
                    }
                } label:{
                    Text(expenseType == "" ? "Filter" : expenseType)
                        .foregroundStyle(.gray)
                }
            }
        }
        .sheet(isPresented: $showingAddExpense) {
            AddView(expenses: expenses)
        }
    }
    
    
}
