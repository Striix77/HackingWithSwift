//
//  ContentView.swift
//  WordScramble
//
//  Created by Freak on 23.03.2026.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = GameViewModel()

    init() {
        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor: UIColor(
                red: 0.863,
                green: 0.863,
                blue: 0.863,
                alpha: 1
            )
        ]
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor(
                red: 0.863,
                green: 0.863,
                blue: 0.863,
                alpha: 1
            )
        ]
    }

    var body: some View {
        NavigationStack {
            ZStack {
                backgroundColor
                List {
                    RootWordTitleView(rootWord: viewModel.rootWord)
                    ScrambledWordInputView(newWord: $viewModel.newWord)
                    ScrambledWordListView(usedWords: viewModel.usedWords)
                }
                .navigationTitle("WordScramble")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        Button("Restart") {
                            viewModel.startGame()
                        }
                    }

                    ToolbarItem(placement: .topBarTrailing) {
                        Text("Score: \(viewModel.score)")
                            .padding()
                    }
                }
                .scrollContentBackground(.hidden)

            }
            .onSubmit(viewModel.addNewWord)
            .onAppear(perform: viewModel.startGame)
            .alert(viewModel.errorTitle, isPresented: $viewModel.showingError) {

            } message: {
                Text(viewModel.errorMessage)
            }

        }
    }
    
    var backgroundColor: some View {
        Color(red: 0.18, green: 0.294, blue: 0.38)
            .ignoresSafeArea()
    }

}

struct RootWordTitleView: View {
    let rootWord: String
    var body: some View {
        Section {
            HStack {
                Spacer()
                Text(rootWord)
                    .font(.largeTitle)
                Spacer()
            }

        }
        .listRowBackground(
            Color(red: 0.18, green: 0.294, blue: 0.38)
        )
        .foregroundStyle(
            Color(
                red: 0.863,
                green: 0.863,
                blue: 0.863,
                opacity: 1
            )
        )
    }
}

struct ScrambledWordInputView: View {
    @Binding var newWord: String
    var body: some View {
        Section {
            TextField(
                "",
                text: $newWord,
                prompt: Text("Enter your word").foregroundStyle(
                    Color.gray
                )
            )
            .textInputAutocapitalization(.never)
            .foregroundStyle(Color.white)

        }
        .listRowBackground(
            Color(red: 0.145, green: 0.239, blue: 0.31)
        )
    }
}

struct ScrambledWordListView: View {
    let usedWords: [String]
    var body: some View {
        Section {
            ForEach(usedWords, id: \.self) { word in
                HStack {
                    Spacer()
                    Image(systemName: "\(word.count).circle")
                        .foregroundStyle(Color.white)
                    Text(word)
                        .foregroundStyle(Color.white)
                    Spacer()
                }
                .listRowBackground(
                    Color(red: 0.145, green: 0.239, blue: 0.31)
                )
            }
        }
    }
}

#Preview {
    ContentView()
}
