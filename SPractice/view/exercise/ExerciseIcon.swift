//
//  ExerciseIcon.swift
//  SPractice
//
//  Created by Yuliya Charniak on 17.08.22.
//

import SwiftUI

struct ExerciseIcon: View {

    private var exerciseType: ExerciseType?
    private var isIconAccented: Bool
    private var accentColor: Color
    private var isFilled: Bool

    init(for exerciseType: ExerciseType?, isIconAccented: Bool = false, accentColor: Color = .customAccentColor, isFilled: Bool = false) {
        self.exerciseType = exerciseType
        self.isIconAccented = isIconAccented
        self.accentColor = accentColor
        self.isFilled = isFilled
    }

    var body: some View {
        if isIconAccented {
            ExerciseTypeImage(type: exerciseType, isFilled: isFilled)
                .foregroundColor(accentColor)
        } else {
            ExerciseTypeImage(type: exerciseType, isFilled: isFilled)
        }
    }
}

struct ExerciseIcon_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseIcon(for: ExerciseType.flow)
    }
}
