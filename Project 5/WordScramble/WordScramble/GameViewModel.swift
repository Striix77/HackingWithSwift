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

    func startGame(with fixedWord: String? = nil) {
        if let word = fixedWord {
            rootWord = word
            usedWords.removeAll()
            score = 0
            return
        }
        
        if let startWordsURL = Bundle.main.url(
            forResource: "start",
            withExtension: "txt"
        ) {
            if let startWords = try? String(
                contentsOf: startWordsURL,
                encoding: .utf8
            ) {
                let allWords = startWords.components(separatedBy: "\n")
                if ProcessInfo.processInfo.arguments.contains("-testMode") {
                    rootWord = "scrumptious"
                } else {
                    rootWord = allWords.randomElement() ?? "moist"
                }
                withAnimation {
                    usedWords.removeAll()
                }
                score = 0
                return
            }
        }
        fatalError(GameStrings.fatalError)
    }

    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !isTooShort(answer) else {
            wordError(
                title: GameStrings.isTooShortTitle,
                message: GameStrings.isTooShortMessage
            )
            return
        }

        guard isOriginal(answer) else {
            wordError(
                title: GameStrings.isOriginalTitle,
                message: GameStrings.isOriginalMessage
            )
            return
        }

        guard isReal(answer) else {
            wordError(
                title: GameStrings.isRealTitle,
                message: GameStrings.isRealMessage
            )
            return
        }

        guard isPossible(answer) else {
            wordError(
                title: GameStrings.isPossibleTitle,
                message: GameStrings.isPossibleMessage(rootWord)

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
        print("MISSPELLED: \(misspelledRange.location)")
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
