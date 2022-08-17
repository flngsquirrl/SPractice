//
//  ExerciseIconButton.swift
//  SPractice
//
//  Created by Yuliya Charniak on 17.08.22.
//

import SwiftUI

struct ExerciseIconButton: View {
    
    private var exerciseType: ExerciseType?
    private var isIconAccented: Bool
    private var accentColor: Color
    private var isFilled: Bool
    
    private var onClick: () -> Void
    
    init(for exerciseType: ExerciseType?, isIconAccented: Bool = false, accentColor: Color = .customAccentColor, isFilled: Bool = false, onClick: @escaping () -> Void) {
        self.exerciseType = exerciseType
        self.isIconAccented = isIconAccented
        self.accentColor = accentColor
        self.isFilled = isFilled
        self.onClick = onClick
    }
    
    var body: some View {
        Button {
            onClick()
        } label: {
            ExerciseIcon(for: exerciseType, isIconAccented: isIconAccented, accentColor: accentColor, isFilled: isFilled)
        }
    }
}

struct ExerciseIconButton_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseIconButton(for: .flow, onClick: {})
    }
}
