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
    
    }

}
