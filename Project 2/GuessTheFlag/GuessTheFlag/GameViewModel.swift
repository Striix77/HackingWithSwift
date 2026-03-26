//
//  GameViewModel.swift
//  GuessTheFlag
//
//  Created by Freak on 26.03.2026.
//
import SwiftUI

@Observable
class GameViewModel {
    private(set) var countries = [
        "Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland",
        "Spain", "UK", "Ukraine", "US",
    ].shuffled()
    private(set) var correctAnswer = Int.random(in: 0...2)
    private(set) var scoreTitle = ""
    private(set) var score = 0
    private(set) var alertMessage = ""
    private(set) var maxRoundNumber = 8
    private(set) var roundNumber = 0
    
    var showingScore = false
    var showingFinalScore = false

    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct!"
            score += 10
            alertMessage = "You got it right! Nice job!"
        } else {
            scoreTitle = "Wrong!"
            score -= 10
            if score < 0 {
                score = 0
            }
            alertMessage =
                "So close! That is the flag of \(countries[number])!"
        }
        if roundNumber == maxRoundNumber - 1 {
            alertMessage += "\nYour final score is \(score)!"
            showingFinalScore = true
        } else {
            alertMessage += "\nYour score is \(score)!"
            showingScore = true
        }

    }

    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        roundNumber += 1
    }

    func reset() {
        askQuestion()
        if roundNumber == maxRoundNumber {
            roundNumber = 0
            score = 0
        }
    }

}
