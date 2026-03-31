//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Freak on 31.03.2026.
//

import SwiftUI

struct AddressView: View {
    @Bindable var order: Order

    var body: some View {
        Form {
            addressDetailsSection
            checkoutSection
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var addressDetailsSection: some View {
        Section {
            TextField("Name", text: $order.name)
            TextField("Street Address", text: $order.streetAddress)
            TextField("City", text: $order.city)
            TextField("Zip", text: $order.zip)
        }
    }
    
    private var checkoutSection: some View{
        Section {
            NavigationLink("Check out") {
                CheckoutView(order: order)
            }
        }
        .disabled(order.hasValidAddress == false)
    }
}

#Preview {
    AddressView(order: Order())
}
