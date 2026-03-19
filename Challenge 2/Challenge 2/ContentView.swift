//
//  ContentView.swift
//  Challenge 2
//
//  Created by Freak on 19.03.2026.
//

import SwiftUI

enum Moves: String, CaseIterable {
    case rock, paper, scissors

    static func random() -> Moves {
        return allCases.randomElement() ?? .rock
    }

    var emoji: String {
        switch self {
        case .rock: return "🪨"
        case .paper: return "📄"
        case .scissors: return "✂️"
        }
    }
}

struct ContentView: View {
    @State private var currentChoice: Moves = .random()
    @State private var shouldWin: Bool = Bool.random()
    var body: some View {
        NavigationView {
            VStack {
                ZStack{
                    Color(red: 0.1, green: 0.6, blue: 0.75, opacity: 1).ignoresSafeArea()
                    VStack {
                        Text("Score: ???")
                            .font(.largeTitle)
                        Text("Current move: ???")
                            .font(.title)
                        Text("You should try to \(shouldWin ? "win" : "lose")")
                            .font(.title)
                        
                        Spacer()
                        
                        VStack {
                            HStack {
                                ForEach(Moves.allCases, id: \.self) { move in
                                    Button(move.emoji) {
                                        
                                    }
                                    .buttonStyle(.bordered)
                                    .font(.system(size: 70))
                                }
                            }
                        }
                        Spacer()
                        
                    }
                }

            }
            .navigationTitle("Guided RPS")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}
