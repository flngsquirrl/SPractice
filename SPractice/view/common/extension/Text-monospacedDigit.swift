//
//  Text-Monospaced.swift
//  SPractice
//
//  Created by Yuliya Charniak on 14.09.22.
//

import SwiftUI

extension Text {

    func monospacedDigit(font: Font?) -> Text {
        var baseFont = Font.system(.body)
        if let font = font {
            baseFont = font
        }

        return self
            .font(baseFont.monospacedDigit())
    }
}
