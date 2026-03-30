//
//  ContentView.swift
//  Navigation
//
//  Created by Freak on 30.03.2026.
//

import SwiftUI

struct ContentView: View {
    @State private var pathStore = PathStore()
    @State private var stringTitle = ""

    var body: some View {
        NavigationStack(path: $pathStore.path) {
            DetailView(number: 0, path: $pathStore.path)
                .navigationDestination(for: Int.self) { i in
                    DetailView(number: i, path: $pathStore.path)
                }
            stringNavigationList
        }
    }

    private var stringNavigationList: some View {
        List(0..<100) { i in
            NavigationLink("Select \(i)", value: String(i + 7))
        }
        .navigationDestination(for: String.self) { selection in
            VStack {
                List(0..<100) { number in
                    stringTitle = selection
                    return Text(
                        "\(number). You selected \(selection). That's a string btw."
                    )
                }

            }
            .navigationTitle($stringTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.blue)
            .toolbarColorScheme(.light)
        }
    }
}

#Preview {
    ContentView()
}
