//
//  ContentView.swift
//  Challenge 2
//
//  Created by Freak on 19.03.2026.
//

import SwiftUI

struct ContentView: View {
    
    @State private var viewModel = GameViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                backgroundGradient
                VStack {
                    ScoreView(playerScore: viewModel.playerScore, botScore: viewModel.botScore)
                    InstructionView(shouldWin: viewModel.shouldWin)

                    Spacer()

                    MoveSelectionView(
                        currentMove: viewModel.currentMove,
                        processPlayerChoice: viewModel.processPlayerChoice
                    )

                    Spacer()

                    resetButton

                }

            }
            .alert(
                viewModel.alertTitle,
                isPresented: $viewModel.showAlert
            ) {
                Button("Continue") {
                    viewModel.resetGameLogic()
                }
            } message: {
                Text(viewModel.alertDetails)
            }
        }
    }

    var backgroundGradient: some View {
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
    }

    var resetButton: some View {
        Button("Reset") {
            viewModel.resetGame()
        }
        .opacity(viewModel.showResetButton ? 1.0 : 0.0)
        .disabled(!viewModel.showResetButton)
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

struct ScoreView: View {
    let playerScore: Int
    let botScore: Int
    var body: some View {
        HStack {
            Text("You: \(playerScore)")
                .font(.title3)
            Spacer()
            Text("Bot: \(botScore)")
                .font(.title3)
        }
        .padding(.horizontal, 10)
    }
}

struct InstructionView: View {
    let shouldWin: Bool
    var body: some View {
        HStack {
            Text("You should try to")
                .font(.title)
            Text(
                shouldWin ? "win" : "lose"
            )
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
    }
}

struct MoveSelectionView: View {
    let currentMove: Moves
    let processPlayerChoice: (Moves) -> Void
    var body: some View {
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
    }
}

#Preview {
    ContentView()
}

#Preview("Romanian") {
    ContentView()
        .environment(\.locale, Locale(identifier: "ro"))
}
