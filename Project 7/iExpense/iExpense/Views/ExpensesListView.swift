//
//  ExpensesListView.swift
//  iExpense
//
//  Created by Freak on 26.03.2026.
//
import SwiftUI

struct ExpensesListView: View {
    @State var expenseType = ""
    
    let expenses: Expenses
    var removeItems: (IndexSet) -> Void
    var expenseTypes = AppDefaults.expenseTypesFilters
    
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
        .accessibilityIdentifier(AppDefaults.expansesAccessibilityID)
        .navigationTitle(AppDefaults.navigationTitle)
        .toolbar {
                addExpenseButton
                filterMenu
        }
    }
    
    private var addExpenseButton: some ToolbarContent {
        ToolbarItem(placement: .bottomBar) {
            NavigationLink(AppDefaults.addExpansesButton){
                AddView(expenses: expenses)
            }
        }
    }
    
    private var filterMenu: some ToolbarContent {
        ToolbarItem(placement:.topBarTrailing) {
            Menu{
                Picker("", selection:$expenseType){
                    ForEach(expenseTypes, id: \.self) {
                        Text($0)
                    }
                }
            } label:{
                Text(expenseType == "" ? AppDefaults.filterLabel : expenseType)
                    .foregroundStyle(.gray)
            }
        }
    }
    
    
}


