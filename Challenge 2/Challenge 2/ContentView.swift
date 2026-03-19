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

    func beats(_ move: Moves) -> Bool {
        switch self {
        case .rock:
            return move != Moves.rock && move != Moves.paper
        case .paper:
            return move != Moves.paper && move != Moves.scissors
        case .scissors:
            return move != Moves.scissors && move != Moves.rock
        }
    }
}

struct ContentView: View {
    @State private var currentMove: Moves = .random()
    @State private var shouldWin: Bool = Bool.random()
    @State private var score: Int = 0 {
        didSet{
            if score < 0 {
                score = 0
            }
        }
    }
    @State private var showAlert: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertDetails: String = ""

    func processPlayerChoice(_ playerMove: Moves) {
        if (shouldWin && playerMove.beats(currentMove))
            || (!shouldWin && !playerMove.beats(currentMove))
        {
            alertTitle = "You Win!"
            alertDetails = "Nice job! You sure showed the randomizer!"
            score += 10
        } else {
            alertTitle = "You Lose!"
            alertDetails = "Well well...\nBetter luck next time champ!"
            score -= 10
            
        }
        showAlert = true

    }

    func resetGame() {
        currentMove = .random()
        shouldWin = Bool.random()
        showAlert = false
    }

    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Color(red: 0.1, green: 0.6, blue: 0.75, opacity: 1)
                        .ignoresSafeArea()
                    VStack {
                        Text("Score: \(score)")
                            .font(.largeTitle)
                        Text("Current move: \(currentMove.emoji)")
                            .font(.title)
                        HStack {
                            Text("You should try to")
                                .font(.title)
                            Text("\(shouldWin ? "win" : "lose")")
                                .font(.title)
                                .foregroundStyle(
                                    shouldWin
                                        ? Color(
                                            red: 0.4,
                                            green: 0.9,
                                            blue: 0.4,
                                            opacity: 1
                                        )
                                        : Color(
                                            red: 0.5,
                                            green: 0.2,
                                            blue: 0.2,
                                            opacity: 1
                                        )
                                )
                        }

                        Spacer()

                        VStack {
                            HStack {
                                ForEach(Moves.allCases, id: \.self) { move in
                                    Button(move.emoji) {
                                        processPlayerChoice(move)
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
            .alert(
                alertTitle,
                isPresented: $showAlert
            ) {
                Button("Continue") {
                    resetGame()
                }
            } message: {
                Text(alertDetails)
            }
        }
    }
}

#Preview {
    ContentView()
}
