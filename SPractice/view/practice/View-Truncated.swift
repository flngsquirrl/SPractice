//
//  View-Truncated.swift
//  SPractice
//
//  Created by Yuliya Charniak on 16.07.22.
//

import SwiftUI

import SwiftUI

struct Truncated: ViewModifier {
    func body(content: Content) -> some View {
        content
            .lineLimit(1)
            .truncationMode(.tail)
    }
}

extension View {
    func truncated() -> some View {
        modifier(Truncated())
    }
}
