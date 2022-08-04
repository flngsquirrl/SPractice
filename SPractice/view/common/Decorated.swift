//
//  Decorated.swift
//  SPractice
//
//  Created by Yuliya Charniak on 20.07.22.
//

import Foundation
import SwiftUI

struct Decorated: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title.weight(.light))
    }
}

extension View {
    func decorated() -> some View {
        modifier(Decorated())
    }
}
