//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Freak on 31.03.2026.
//

import SwiftUI

struct CheckoutView: View {
    @State private var viewModel : CheckoutViewModel
    var order: Order
    
    init(order: Order) {
        self.order = order
        self.viewModel = CheckoutViewModel(order: order)
    }

    var body: some View {
        ScrollView {
            VStack {
                CheckoutHeaderView(order: order)

                Button("Place Order") {
                    Task{
                        await viewModel.placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Thank you!", isPresented: $viewModel.showingConfirmation) {
            Button("OK") { }
        } message: {
            Text(viewModel.confirmationMessage)
        }
    }

}

private struct CheckoutHeaderView: View {
    var order: Order
    var body: some View {
        AsyncImage(
            url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"),
            scale: 3
        ) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            ProgressView()
        }
        .frame(height: 233)
        Text("Your total is \(order.cost, format: .currency(code: "USD"))")
            .font(.title)
    }
}

#Preview {
    CheckoutView(order: Order())
}
