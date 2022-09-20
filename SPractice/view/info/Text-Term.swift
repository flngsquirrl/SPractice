//
//  Text-Term.swift
//  SPractice
//
//  Created by Yuliya Charniak on 12.09.22.
//

import Foundation
import SwiftUI

extension Text {
    func term() -> Text {
        self
            .fontWeight(.semibold)
            .foregroundColor(.customAccentColor)
    }
}
