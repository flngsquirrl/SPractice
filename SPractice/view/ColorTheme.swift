//
//  ColorTheme.swift
//  SPractice
//
//  Created by Yuliya Charniak on 8.05.22.
//

import Foundation
import SwiftUI

extension ShapeStyle where Self == Color {

    private static var lightOrange: Color {
        Color(red: 216/255, green: 153/255, blue: 91/255)
    }

    static var textColor: Color {
        white
    }

    static var mainColor: Color {
        lightOrange
    }

    static var customAccentColor: Color {
        mainColor
    }
}
