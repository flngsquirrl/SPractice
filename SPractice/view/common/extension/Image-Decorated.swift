//
//  Image-Decorated.swift
//  SPractice
//
//  Created by Yuliya Charniak on 20.07.22.
//

import Foundation
import SwiftUI

extension Image {

    struct Decorated: ViewModifier {
        func body(content: Content) -> some View {
            content
                .font(.title.weight(.light))
        }
    }

    func decorated() -> some View {
        modifier(Decorated())
    }
}
