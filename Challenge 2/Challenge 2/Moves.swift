//
//  Moves.swift
//  Challenge 2
//
//  Created by Freak on 24.03.2026.
//
import Foundation

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
