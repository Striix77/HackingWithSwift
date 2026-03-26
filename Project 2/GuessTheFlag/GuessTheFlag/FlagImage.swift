//
//  FlagImage.swift
//  GuessTheFlag
//
//  Created by Freak on 26.03.2026.
//
import SwiftUI

struct FlagImage: View {
    let imgURL: String
    
    var body: some View {
        Image(imgURL)
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}
