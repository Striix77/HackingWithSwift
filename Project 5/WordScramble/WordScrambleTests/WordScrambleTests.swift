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
    
    @Test("isOriginal rejects the root word itself or duplicates")
    func testIsOriginal() {
        let viewModel = GameViewModel()
        viewModel.startGame(with: "license")
        
        #expect(viewModel.isOriginal("license") == false)
        #expect(viewModel.isOriginal("silence") == true)
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
    
    }

}
