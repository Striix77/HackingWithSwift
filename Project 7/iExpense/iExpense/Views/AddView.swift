//
//  AddView.swift
//  iExpense
//
//  Created by Freak on 26.03.2026.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    @State private var currency = Locale.current.currency?.identifier ?? "USD"

    let types = ["Business", "Personal"]
    let availableCurrencies: [String] = {
        let locales = Locale.availableIdentifiers.map { Locale(identifier: $0) }
        return Set(locales.compactMap { $0.currency?.identifier })
    }().sorted()

    var expenses: Expenses

    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)

                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                HStack{
                    TextField(
                        "Amount",
                        value: $amount,
                        format: .currency(code: currency)
                    )
                    .keyboardType(.decimalPad)
                    
                    Picker("", selection: $currency) {
                        ForEach(availableCurrencies, id:\.self){
                            Text($0)
                        }
                    }
                }
            }
            .navigationTitle("Add new expense")
            .toolbar{
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount, currency: currency)
                    expenses.items.append(item)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
