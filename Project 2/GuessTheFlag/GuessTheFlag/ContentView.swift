//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Freak on 16.03.2026.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = [
        "Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland",
        "Spain", "UK", "Ukraine", "US",
    ].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var showingFinalScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var alertMessage = ""
    @State private var maxRoundNumber = 8
    @State private var roundNumber = 0

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
            alertMessage+="\nYour final score is \(score)!"
            showingFinalScore = true
        }
        else{
            alertMessage+="\nYour score is \(score)!"
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
        if(roundNumber == maxRoundNumber){
            roundNumber = 0
            score = 0
        }
    }

    var body: some View {
        ZStack {
            RadialGradient(
                stops: [
                    .init(
                        color: Color(red: 0.1, green: 0.2, blue: 0.45),
                        location: 0.3
                    ),
                    .init(
                        color: Color(red: 0.76, green: 0.15, blue: 0.26),
                        location: 0.3
                    ),
                ],
                center: .top,
                startRadius: 200,
                endRadius: 400
            )
            .ignoresSafeArea()

            VStack {
                Spacer()
                Text("Guess The Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                Text("Round \(roundNumber+1)")
                    .font(.title)
                    .foregroundStyle(.white)

                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .foregroundStyle(.secondary)
                            .font(.largeTitle.weight(.semibold))
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.regularMaterial)
                    .clipShape(.rect(cornerRadius: 20))

                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                    }

                }

                Spacer()
                Spacer()
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text(alertMessage)

        }
        .alert(scoreTitle, isPresented: $showingFinalScore) {
            Button("Restart", action: reset)
        } message: {
            Text(alertMessage)

        }
    }
}

#Preview {
    ContentView()
}
