//
//  ContentView.swift
//  Animations
//
//  Created by Freak on 25.03.2026.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount = 1.0
    @State private var springAnimationAmount = 1.0
    @State private var easeInOutAnimationAmount = 1.0
    var body: some View {
        Button("Tap me") {
            animationAmount += 1
        }
        .padding(50)
        .background(.red)
        .foregroundStyle(.white)
        .clipShape(.circle)
        .scaleEffect(animationAmount)
        .blur(radius: (animationAmount - 1) * 3)
        .animation(.default, value: animationAmount)

        Button("Spring me") {
            springAnimationAmount += 1
        }
        .padding(50)
        .background(.yellow)
        .foregroundStyle(.black)
        .clipShape(.circle)
        .scaleEffect(springAnimationAmount)
        .animation(
            .spring(duration: 0.5, bounce: 0.3),
            value: springAnimationAmount
        )

        Button("Ease me") {
            easeInOutAnimationAmount += 1
        }
        .padding(50)
        .background(.blue)
        .foregroundStyle(.black)
        .clipShape(.circle)
        .scaleEffect(easeInOutAnimationAmount)
        .animation(
            .easeInOut(duration: 1)
                .delay(1),
            value: easeInOutAnimationAmount
        )

    }
}

#Preview {
    ContentView()
}
