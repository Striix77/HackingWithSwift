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
    @State private var playerScore: Int = 0
    @State private var botScore: Int = 0
    @State private var showAlert: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertDetails: String = ""

    func processPlayerChoice(_ playerMove: Moves) {
        if (shouldWin && playerMove.beats(currentMove))
            || (!shouldWin && !playerMove.beats(currentMove))
        {
            alertTitle = "You Win!"
            alertDetails = "Nice job! You sure showed the randomizer!"
            playerScore += 1
        } else {
            alertTitle = "You Lose!"
            alertDetails = "Well well...\nBetter luck next time champ!"
            botScore += 1

        }
        showAlert = true

    }

    func resetGameLogic() {
        currentMove = .random()
        shouldWin = Bool.random()
        showAlert = false
    }

    func resetGame() {
        resetGameLogic()
        playerScore = 0
        botScore = 0
    }

    var showResetButton: Bool {
        playerScore > 0 || botScore > 0
    }

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    stops: [
                        .init(
                            color: Color(
                                red: 0.1,
                                green: 0.6,
                                blue: 0.75,
                                opacity: 1
                            ),
                            location: 0.0
                        ),
                        .init(
                            color: Color(
                                red: 0.9,
                                green: 0.5,
                                blue: 0.1,
                                opacity: 1
                            ),
                            location: 1.0
                        ),
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                VStack {
                    HStack {
                        Text("You: \(playerScore)")
                            .font(.title3)
                        Spacer()
                        Text("Bot: \(botScore)")
                            .font(.title3)
                    }
                    .padding(.horizontal, 10)
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

                    VStack(spacing: 100) {
                        Text(currentMove.emoji)
                            .font(.system(size: 80))
                        Text("vs.")
                            .font(.title)
                        HStack(spacing: 50) {
                            ForEach(Moves.allCases, id: \.self) { move in
                                Button(move.emoji) {
                                    processPlayerChoice(move)
                                }
                                .buttonStyle(.borderless)
                                .font(.system(size: 80))
                            }
                        }

                    }
                    Spacer()

                    Button("Reset") {
                        resetGame()
                    }
                    .opacity(showResetButton ? 1.0 : 0.0)
                    .disabled(!showResetButton)
                    .buttonStyle(.bordered)
                    .font(.title3)
                    .foregroundStyle(
                        Color(
                            red: 0.1,
                            green: 0.1,
                            blue: 0.1,
                            opacity: 1
                        )
                    )

                }

            }
            .alert(
                alertTitle,
                isPresented: $showAlert
            ) {
                Button("Continue") {
                    resetGameLogic()
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
