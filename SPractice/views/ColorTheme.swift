//
//  ColorTheme.swift
//  SPractice
//
//  Created by Yuliya Charniak on 8.05.22.
//

import Foundation
import SwiftUI

extension ShapeStyle where Self == Color {
    static var darkNavy: Color {
        Color(red: 17/255, green: 43/255, blue: 60/255)
    }

    static var lightNavy: Color {
        Color(red: 32/255, green: 83/255, blue: 117/255)
    }
    
    static var lightOrange: Color {
        Color(red: 255/255, green: 141/255, blue: 41/255)
    }
    
    static var darkOrange: Color {
        Color(red: 224/255, green: 77/255, blue: 1/255)
    }
    
    static var creamy: Color {
        Color(red: 239/255, green: 239/255, blue: 239/255)
    }
}
