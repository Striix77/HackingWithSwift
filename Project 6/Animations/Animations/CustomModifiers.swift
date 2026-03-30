//
//  CustomModifiers.swift
//  Animations
//
//  Created by Freak on 30.03.2026.
//
import SwiftUI

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint

    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

struct AnimatedButtonStyle: ViewModifier {
    var color: Color
    var textColor: Color = .white

    func body(content: Content) -> some View {
        content
            .padding(50)
            .background(color)
            .foregroundStyle(textColor)
            .clipShape(.circle)
    }
}
