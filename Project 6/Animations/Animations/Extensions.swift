//
//  Extensions.swift
//  Animations
//
//  Created by Freak on 30.03.2026.
//
import SwiftUI

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
        )
    }
}

extension View {
    func animatedButtonStyle(color: Color, textColor: Color = .white) -> some View {
        modifier(AnimatedButtonStyle(color: color, textColor: textColor))
    }
}
