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
    
    private let checker = UITextChecker()


    var showingError = false
    
    func resetGame() {
        withAnimation {
            usedWords.removeAll()
        }
        score = 0
    }

    func loadRootWord(from startWordsURL: URL?) throws {
        guard let url = startWordsURL else {
            throw GameError.fileNotFound
        }

        let startWords: String
        do {
            startWords = try String(contentsOf: url, encoding: .utf8)
        } catch {
            throw GameError.decodingFailed
        }

        let allWords = startWords.components(separatedBy: "\n").filter {
            !$0.isEmpty
        }

        guard !allWords.isEmpty else {
            throw GameError.emptyFile
        }

        if ProcessInfo.processInfo.arguments.contains("-testMode") {
            rootWord = "scrumptious"
        } else {
            rootWord = allWords.randomElement() ?? "moist"
        }

    }

    func loadStartWords() throws {
        if let startWordsURL = Bundle.main.url(
            forResource: "start",
            withExtension: "txt"
        ) {
            try loadRootWord(from: startWordsURL)
        }
    }

    func startGame(with fixedWord: String? = nil) {
        if let word = fixedWord {
            rootWord = word
            resetGame()
            return
        }
        do {
            try loadStartWords()
            resetGame()
        } catch {
            fatalError(GameStrings.fatalError)
        }
    }

    func addNewWord(newWord: String) {
        let answer = newWord.lowercased().trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !isTooShort(answer) else {
            showError(
                title: GameStrings.isTooShortTitle,
                message: GameStrings.isTooShortMessage
            )
            return
        }

        guard isOriginal(answer) else {
            showError(
                title: GameStrings.isOriginalTitle,
                message: GameStrings.isOriginalMessage
            )
            return
        }

        guard isReal(answer) else {
            showError(
                title: GameStrings.isRealTitle,
                message: GameStrings.isRealMessage
            )
            return
        }

        guard isPossible(answer) else {
            showError(
                title: GameStrings.isPossibleTitle,
                message: GameStrings.isPossibleMessage(rootWord)

            )
            return
        }

        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        score += answer.count
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

    func showError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }

}
