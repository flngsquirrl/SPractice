//
//  ColorTheme.swift
//  SPractice
//
//  Created by Yuliya Charniak on 8.05.22.
//

import Foundation
import SwiftUI

extension ShapeStyle where Self == Color {

    static var lightOrange: Color {
        Color(red: 216/255, green: 153/255, blue: 91/255)
    }

    static var creamy: Color {
        Color(red: 239/255, green: 239/255, blue: 239/255)
    }

    static var customAccentColor: Color {
        lightOrange
    }
}
