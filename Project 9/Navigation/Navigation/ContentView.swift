//
//  ContentView.swift
//  Navigation
//
//  Created by Freak on 30.03.2026.
//

import SwiftUI

struct ContentView: View {
    @State private var path = NavigationPath()

        var body: some View {
            NavigationStack(path: $path) {
                DetailView(number: 0, path: $path)
                    .navigationDestination(for: Int.self) { i in
                        DetailView(number: i, path: $path)
                    }
    }
        }
}

#Preview {
    ContentView()
}
