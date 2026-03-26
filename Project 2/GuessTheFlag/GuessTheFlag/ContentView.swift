//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Freak on 16.03.2026.
//

import SwiftUI

struct ContentView: View {
    @State var viewModel = GameViewModel()
    var body: some View {
        ZStack {
            backgroundGradient
            VStack {
                Spacer()
                Text("Guess The Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                Text("Round \(viewModel.roundNumber+1)")
                    .font(.title)
                    .foregroundStyle(.white)

                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(viewModel.countries[viewModel.correctAnswer])
                            .foregroundStyle(.secondary)
                            .font(.largeTitle.weight(.semibold))
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.regularMaterial)
                    .clipShape(.rect(cornerRadius: 20))

                    ForEach(0..<3) { number in
                        Button {
                            viewModel.flagTapped(number)
                        } label: {
                            FlagImage(imgURL: viewModel.countries[number])
                        }
                    }

                }

                Spacer()
                Spacer()
                Text("Score: \(viewModel.score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
        }
        .alert(viewModel.scoreTitle, isPresented: $viewModel.showingScore) {
            Button("Continue", action: viewModel.askQuestion)
        } message: {
            Text(viewModel.alertMessage)

        }
        .alert(viewModel.scoreTitle, isPresented: $viewModel.showingFinalScore) {
            Button("Restart", action: viewModel.reset)
        } message: {
            Text(viewModel.alertMessage)

        }
    }
    
    var backgroundGradient: some View{
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
    }
}

#Preview {
    ContentView()
}
