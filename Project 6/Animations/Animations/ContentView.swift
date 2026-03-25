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
    @State private var repeatAnimationAmount = 1.0
    @State private var overlayAnimationAmount = 1.0
    @State private var stepperAnimationAmount = 1.0
    var body: some View {
        Button("Tap me") {
            animationAmount += 0.5
        }
        .padding(50)
        .background(.red)
        .foregroundStyle(.white)
        .clipShape(.circle)
        .scaleEffect(animationAmount)
        .blur(radius: (animationAmount - 1) * 3)
        .animation(.default, value: animationAmount)

        Button("Spring me") {
            springAnimationAmount += 0.5
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
            easeInOutAnimationAmount += 0.5
        }
        .padding(50)
        .background(.blue)
        .foregroundStyle(.white)
        .clipShape(.circle)
        .scaleEffect(easeInOutAnimationAmount)
        .animation(
            .easeInOut(duration: 1)
                .delay(1),
            value: easeInOutAnimationAmount
        )
        Button("Repeat me") {
            repeatAnimationAmount = 1.5
        }
        .padding(50)
        .background(.green)
        .foregroundStyle(.white)
        .clipShape(.circle)
        .scaleEffect(repeatAnimationAmount)
        .animation(
            .easeInOut(duration: 1)
                .repeatForever(autoreverses: true),
            value: repeatAnimationAmount
        )

        Button("Pulse me") {
            overlayAnimationAmount = 2
        }
        .padding(50)
        .background(.cyan)
        .foregroundStyle(.white)
        .clipShape(.circle)
        .overlay(
            Circle()
                .stroke(.cyan)
                .scaleEffect(overlayAnimationAmount)
                .opacity(2 - overlayAnimationAmount)
                .animation(
                    .easeOut(duration: 1)
                        .repeatForever(autoreverses: false),
                    value: overlayAnimationAmount
                )
        )

        VStack {
            Stepper("Scale amount", value: $stepperAnimationAmount.animation(
                .easeInOut(duration: 0.5)
                    .repeatCount(3, autoreverses: true)
            ), in: 1...10)

            Spacer()

            Button("Tap Me") {
                stepperAnimationAmount += 0.5
            }
            .padding(40)
            .background(.red)
            .foregroundStyle(.white)
            .clipShape(.circle)
            .scaleEffect(stepperAnimationAmount)
        }

    }
}

#Preview {
    ContentView()
}
