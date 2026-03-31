//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Freak on 31.03.2026.
//

import SwiftUI

struct ContentView: View {
    @State private var order = Order()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
