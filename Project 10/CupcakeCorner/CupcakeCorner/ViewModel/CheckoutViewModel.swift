//
//  CheckoutViewModel.swift
//  CupcakeCorner
//
//  Created by Freak on 31.03.2026.
//
import SwiftUI

@Observable
class CheckoutViewModel {
    private(set) var confirmationMessage = ""
    var showingConfirmation = false

    var order: Order

    init(order: Order) {
        self.order = order
    }

    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Mobile/15E148 Safari/604.1", forHTTPHeaderField: "User-Agent")
        request.httpMethod = "POST"

        do {
            let (data, _) = try await URLSession.shared.upload(
                for: request,
                from: encoded
            )
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage =
                "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
        } catch {
            
            print("Checkout failed: \(error)")
        }
    }
}
