//
//  GameStrings.swift
//  WordScramble
//
//  Created by Freak on 25.03.2026.
//
import SwiftUI

enum GameStrings {
    static let fatalError = "Could not load start.txt from bundle!"
    static let isTooShortTitle = "Word is too short!"
    static let isTooShortMessage = "Length does matter!"
    static let isOriginalTitle = "Word used already!"
    static let isOriginalMessage = "Try another one!"
    static let isPossibleTitle = "Word not possible!"
    static var isPossibleMessage : (String) -> String = { rootWord in
        "You can't spell that word from '\(rootWord)'s letters!"
    }
    static let isRealTitle = "Word not recognized!"
    static let isRealMessage = "You can't just make 'em up!"
}
