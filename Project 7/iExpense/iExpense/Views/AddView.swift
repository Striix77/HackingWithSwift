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
    @State private var type = AppDefaults.defaultType
    @State private var amount = AppDefaults.defaultAmount
    @State private var currency = Locale.current.currency?.identifier ?? AppDefaults.defaultCurrency

    let types = AppDefaults.expenseTypes
    let availableCurrencies: [String] = {
        let locales = Locale.availableIdentifiers.map { Locale(identifier: $0) }
        return Set(locales.compactMap { $0.currency?.identifier })
    }().sorted()

    var expenses: Expenses

    var body: some View {
        NavigationStack {
            Form {
                TextField(AppDefaults.namePlaceholder, text: $name)
                    .accessibilityIdentifier(AppDefaults.nameAccessibilityID)

                Picker(AppDefaults.typeLabel, selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                HStack{
                    TextField(
                        AppDefaults.amountPlaceholder,
                        value: $amount,
                        format: .currency(code: currency)
                    )
                    .keyboardType(.decimalPad)
                    .accessibilityIdentifier(AppDefaults.amountAccessibilityID)
                    
                    Picker("", selection: $currency) {
                        ForEach(availableCurrencies, id:\.self){
                            Text($0)
                        }
                    }
                }
            }
            .navigationTitle(AppDefaults.navigationTitle)
            .toolbar{
                Button(AppDefaults.saveButton) {
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
