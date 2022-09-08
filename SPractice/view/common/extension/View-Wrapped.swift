//
//  View-Wrapped.swift
//  SPractice
//
//  Created by Yuliya Charniak on 30.06.22.
//

import Foundation
import SwiftUI

struct Wrapped: ViewModifier {
    var color = Color(UIColor.secondarySystemBackground)

    func body(content: Content) -> some View {
        content
            .padding()
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

extension View {
    func wrapped(color: Color = Color(UIColor.secondarySystemBackground)) -> some View {
        modifier(Wrapped(color: color))
    }
}
