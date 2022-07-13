//
//  LayoutUtils.swift
//  SPractice
//
//  Created by Yuliya Charniak on 1.07.22.
//

import Foundation
import SwiftUI

struct LayoutUtils {
    
    static let timeFont: Font = .system(.callout).monospacedDigit()
    
    static let unknownDurationText = Text("?")
    static let unlimitedDurationImage = Image(systemName: "infinity")
    static let approximationMark = Image(systemName: ExerciseTypeImage.imageName(for: .flow))
    
    static let durationSectionFooter = Text("Duration is the time needed to complete all timer and tabata exercises. Flow symbol before the actual time means that the program contains flow exercises")
}
