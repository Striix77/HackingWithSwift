//
//  Challenge_2Tests.swift
//  Challenge 2Tests
//
//  Created by Freak on 19.03.2026.
//

import SwiftUI
import Testing

@testable import Challenge_2

@MainActor
struct Challenge_2Tests {

    @Test(
        "Player scores a point when they correctly follow the win instruction"
    )
    func testPlayerWinsCorrectly() async throws {
        let viewModel = GameViewModel()
        viewModel.currentMove = .rock
        viewModel.shouldWin = true

        viewModel.processPlayerChoice(.paper)

        #expect(viewModel.playerScore == 1)
        #expect(viewModel.botScore == 0)
        #expect(viewModel.showAlert == true)
        #expect(viewModel.alertTitle == "You Win!")
    }

    
}
