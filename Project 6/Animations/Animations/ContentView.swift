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
    @State private var spinAnimationAmount = 1.0
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero

    @State private var arrayEnabled = false
    @State private var arrayDragAmount = CGSize.zero

    @State private var isShowingRed = false
    @State private var isShowingGreen = false
    let letters = Array("Hello SwiftUI")

    var body: some View {
        ScrollView {
            blurryButton
            springyButton
            easingButton
            repeatingButton
            pulsatingButton
            scalingStepper
            spinningButton
            shapeChangingButton
            draggableGradient
            draggableText
            toggleableRectangle
            clippingRectangle
        }
    }

    var blurryButton: some View {
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

    }
    
    var springyButton: some View{
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
    }
    
    var easingButton: some View{
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
    }
    
    var repeatingButton: some View{
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
    }
    
    var pulsatingButton: some View {
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
    }
    
    var scalingStepper: some View{
        VStack {
            Stepper(
                "Scale amount",
                value: $stepperAnimationAmount.animation(
                    .easeInOut(duration: 0.5)
                        .repeatCount(3, autoreverses: true)
                ),
                in: 1...10
            )

            Spacer()

            Button("Tap Me") {
                stepperAnimationAmount += 0.5
            }
            .padding(50)
            .background(.red)
            .foregroundStyle(.white)
            .clipShape(.circle)
            .scaleEffect(stepperAnimationAmount)
        }
    }
    
    var spinningButton: some View{
        Button("Spin Me") {
            withAnimation(.spring(duration: 0.7, bounce: 0.5)) {
                spinAnimationAmount += 360
            }
        }
        .padding(50)
        .background(
            RadialGradient(
                colors: [Color.blue, Color.red],
                center: .center,
                startRadius: 5,
                endRadius: 100
            )
        )
        .foregroundStyle(.white)
        .clipShape(.circle)
        .rotation3DEffect(
            .degrees(spinAnimationAmount),
            axis: (x: 0, y: 1, z: 0)
        )
    }
    
    var shapeChangingButton: some View{
        Button("Rectify Me") {
            enabled.toggle()
        }
        .frame(width: 120, height: 120)
        .background(enabled ? .blue : .red)
        .animation(.default, value: enabled)
        .foregroundStyle(.white)
        .clipShape(.rect(cornerRadius: enabled ? 40 : 0))
        .animation(.spring(duration: 1, bounce: 0.6), value: enabled)
    }
    
    var draggableGradient: some View{
        LinearGradient(
            colors: [.yellow, .red],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .frame(width: 300, height: 200)
        .clipShape(.rect(cornerRadius: 10))
        .offset(dragAmount)
        .gesture(
            DragGesture()
                .onChanged { dragAmount = $0.translation }
                .onEnded { _ in
                    withAnimation(.bouncy) {
                        dragAmount = .zero
                    }
                }
        )
        .accessibilityIdentifier("DraggableGradient")
        //.animation(.bouncy, value:dragAmount)
    }
    
    var draggableText: some View{
        HStack(spacing: 0) {
            ForEach(0..<letters.count, id: \.self) { num in
                Text(String(letters[num]))
                    .padding(5)
                    .font(.title)
                    .background(arrayEnabled ? .blue : .red)
                    .offset(arrayDragAmount)
                    .animation(
                        .linear.delay(Double(num) / 20),
                        value: arrayDragAmount
                    )
            }
        }
        .gesture(
            DragGesture()
                .onChanged { arrayDragAmount = $0.translation }
                .onEnded { _ in
                    arrayDragAmount = .zero
                    arrayEnabled.toggle()
                }
        )
    }
    
    var toggleableRectangle: some View{
        VStack {
            Button("Tap Me") {
                withAnimation {
                    isShowingRed.toggle()
                }
            }
            .accessibilityIdentifier("ToggleRedButton")

            if isShowingRed {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(
                        .asymmetric(insertion: .opacity, removal: .scale)
                    )
                    .accessibilityIdentifier("RedRectangle")
            }
        }
    }
    
    var clippingRectangle: some View{
        ZStack {
            Rectangle()
                .fill(.blue)
                .frame(width: 200, height: 200)

            if isShowingGreen {
                Rectangle()
                    .fill(.green)
                    .frame(width: 200, height: 200)
                    .transition(.pivot)
            }
        }
        .onTapGesture {
            withAnimation {
                isShowingGreen.toggle()
            }
        }
    }

}

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint

    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
        )
    }
}

#Preview {
    ContentView()
}
