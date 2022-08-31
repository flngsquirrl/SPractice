//
//  View-Wrapped.swift
//  SPractice
//
//  Created by Yuliya Charniak on 30.06.22.
//

import Foundation
import SwiftUI

struct Wrapped: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color(UIColor.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

extension View {
    func wrapped() -> some View {
        modifier(Wrapped())
    }
}
