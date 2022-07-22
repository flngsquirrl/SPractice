//
//  ExerciseShortDecorativeView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 27.06.22.
//

import SwiftUI

struct ExerciseShortDecorativeView<T>: View where T: Exercise {
    
    private let exercise: T
    private var displayDetails: Bool
    private var isIconAccented: Bool
    private var isNameAccented: Bool
    private var accentColor: Color
    private var isFilled: Bool
    
    @ObservedObject private var settings = SettingsManager.settings
    
    init(for exercise: T, displayDetails: Bool = true, isIconAccented: Bool = false, isNameAccented: Bool = false, accentColor: Color = .customAccentColor, isFilled: Bool = false) {
        self.exercise = exercise
        self.displayDetails = displayDetails && exercise.isTypeSet
        self.isIconAccented = isIconAccented
        self.isNameAccented = isNameAccented
        self.accentColor = accentColor
        self.isFilled = isFilled
    }
    
    var body: some View {
        HStack {
            if isIconAccented {
                ExerciseTypeImage(type: exercise.type, isFilled: isFilled)
                    .decorated()
                    .foregroundColor(accentColor)
            } else {
                ExerciseTypeImage(type: exercise.type)
                    .decorated()
            }
            
            if isNameAccented {
                Text(exercise.name)
                    .fontWeight(.semibold)
                    .foregroundColor(accentColor)
            } else {
                Text(exercise.name)
                    .fontWeight(.semibold)
            }
            
            Group {
                if displayDetails {
                    Spacer()
                    ExerciseDurationView(for: exercise)
                    IntensityView(intensity: exercise.intensity, mode: .icon)
                }
            }
            .foregroundColor(.secondary)
        }
    }
}

struct ExerciseShortDecorativeView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            Group {
                Text("exercises")
                ExerciseShortDecorativeView(for: ExerciseTemplate.catCow)
                ExerciseShortDecorativeView(for: ExerciseTemplate.surjaNamascarA)
                ExerciseShortDecorativeView(for: ExerciseTemplate.vasihsthasana)
            }
            
            Group {
                Text("templates with durations")
                ExerciseShortDecorativeView(for: ExerciseTemplate.catCowNoDuration, displayDetails: true)
                ExerciseShortDecorativeView(for: ExerciseTemplate.catCow, displayDetails: true)
                ExerciseShortDecorativeView(for: ExerciseTemplate.surjaNamascarA, displayDetails: true)
                ExerciseShortDecorativeView(for: ExerciseTemplate.vasihsthasana, displayDetails: true)
                ExerciseShortDecorativeView(for: ExerciseTemplate.catCowNoType, displayDetails: true)
            }
            
            Group {
                Text("templates without durations")
                ExerciseShortDecorativeView(for: ExerciseTemplate.catCowNoDuration)
                ExerciseShortDecorativeView(for: ExerciseTemplate.catCow)
                ExerciseShortDecorativeView(for: ExerciseTemplate.surjaNamascarA)
                ExerciseShortDecorativeView(for: ExerciseTemplate.vasihsthasana)
                ExerciseShortDecorativeView(for: ExerciseTemplate.catCowNoType)
            }
        }
    }
}
