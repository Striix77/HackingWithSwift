//
//  GameViewModel.swift
//  Challenge 2
//
//  Created by Freak on 24.03.2026.
//
import SwiftUI

@Observable
class GameViewModel {
    var currentMove: Moves = .random()
    var shouldWin: Bool = Bool.random()
    var playerScore: Int = 0
    var botScore: Int = 0
    var showAlert: Bool = false
    var alertTitle: LocalizedStringKey = ""
    var alertDetails: LocalizedStringKey = ""

    var showResetButton: Bool {
        playerScore > 0 || botScore > 0
    }

    func processPlayerChoice(_ playerMove: Moves) {
        var didWin: Bool {
            (shouldWin && playerMove.beats(currentMove))
                || (!shouldWin && !playerMove.beats(currentMove))
        }

        if didWin {
            alertTitle = GameStrings.winTitle
            alertDetails = GameStrings.winDetails
            playerScore += 1
        } else {
            alertTitle = GameStrings.loseTitle
            alertDetails = GameStrings.loseDetails
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
}
