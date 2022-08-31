//
//  Toggle-Decorated.swift
//  SPractice
//
//  Created by Yuliya Charniak on 31.08.22.
//

import Foundation
import SwiftUI

extension Toggle {

    struct Decorated: ViewModifier {
        func body(content: Content) -> some View {
            content
                .tint(.customAccentColor)
        }
    }

    func decorated() -> some View {
        modifier(Decorated())
    }
}
