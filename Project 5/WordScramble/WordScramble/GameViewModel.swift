//
//  GameViewModel.swift
//  WordScramble
//
//  Created by Freak on 25.03.2026.
//
import SwiftUI

@Observable
class GameViewModel {
    private(set) var usedWords = [String]()
    private(set) var rootWord = ""

    private(set) var errorTitle = ""
    private(set) var errorMessage = ""

    private(set) var score = 0

    var newWord = ""

    var showingError = false

    func startGame() {
        if let startWordsURL = Bundle.main.url(
            forResource: "start",
            withExtension: "txt"
        ) {
            if let startWords = try? String(
                contentsOf: startWordsURL,
                encoding: .utf8
            ) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "moist"
                withAnimation {
                    usedWords.removeAll()
                }
                score = 0
                return
            }
        }
        fatalError("Could not load start.txt from bundle!")
    }

    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !isTooShort(answer) else {
            wordError(
                title: "Word is too short!",
                message: "Length does matter!"
            )
            return
        }

        guard isOriginal(answer) else {
            wordError(title: "Word used already!", message: "Try another one!")
            return
        }

        guard isPossible(answer) else {
            wordError(
                title: "Word not possible!",
                message:
                    "You can't spell that word from '\(rootWord)''s letters!"
            )
            return
        }

        guard isReal(answer) else {
            wordError(
                title: "Word not recognized!",
                message: "You can't just make 'em up!"
            )
            return
        }

        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        score += answer.count
        newWord = ""
    }

    func isOriginal(_ word: String) -> Bool {
        word != rootWord && !usedWords.contains(word)
    }

    func isPossible(_ word: String) -> Bool {
        var tempWord = rootWord
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }

        return true
    }

    func isReal(_ word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(
            in: word,
            range: range,
            startingAt: 0,
            wrap: false,
            language: "en"
        )

        return misspelledRange.location == NSNotFound
    }

    func isTooShort(_ word: String) -> Bool {
        word.count < 3
    }

    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }

}
