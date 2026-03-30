//
//  WordScrambleTests.swift
//  WordScrambleTests
//
//  Created by Freak on 23.03.2026.
//

import Testing
@testable import WordScramble

struct WordScrambleTests {

    @Test("isPossible correctly identifies if letters exist in root word")
    func testIsPossible() {
        let viewModel = GameViewModel()
        viewModel.startGame(with: "license")
        
        #expect(viewModel.isPossible("silence") == true)
        #expect(viewModel.isPossible("silences") == false)
    }
    
    @Test("isOriginal rejects the root word itself")
    func testIsOriginalRejectsRootWord() {
        let viewModel = GameViewModel()
        viewModel.startGame(with: "license")
        
        #expect(viewModel.isOriginal("license") == false)
    }
    
    @Test("isOriginal rejects duplicates")
    func testIsOriginalRejectsDuplicates() {
        let viewModel = GameViewModel()
        viewModel.startGame(with: "license")
        
        viewModel.newWord = "silence"
        viewModel.addNewWord()
        #expect(viewModel.isOriginal("silence") == false)
    }
    
    @Test("Adding a valid word increases the score and clears input")
    func testAddingValidWord() {
        let viewModel = GameViewModel()
        viewModel.startGame(with: "license")
        
        viewModel.newWord = "silence"
        viewModel.addNewWord()
        
        #expect(viewModel.score == 7)
        #expect(viewModel.usedWords.count == 1)
        #expect(viewModel.newWord == "")
    }
    
    @Test("Adding a word that is too short triggers an error")
    func testIsTooShort() {
        let viewModel = GameViewModel()
            viewModel.newWord = "it"
            
            viewModel.addNewWord()
            
            #expect(viewModel.showingError == true)
            #expect(viewModel.errorTitle == GameStrings.isTooShortTitle)
    }

}
