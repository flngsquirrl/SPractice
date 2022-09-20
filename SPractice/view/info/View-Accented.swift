//
//  View-Accented.swift
//  SPractice
//
//  Created by Yuliya Charniak on 12.09.22.
//

import Foundation
import SwiftUI

struct Accented: ViewModifier {
    func body(content: Content) -> some View {
        content
            .fontWeight(.semibold)
            .foregroundColor(.customAccentColor)
    }
}

extension View {
    func accented() -> some View {
        modifier(Accented())
    }
}
