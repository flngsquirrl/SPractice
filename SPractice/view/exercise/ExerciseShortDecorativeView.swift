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
    private var accentColor: Color
    private var isFilled: Bool
    
    init(for exercise: T, displayDetails: Bool = true, isIconAccented: Bool = false, accentColor: Color = .primary, isFilled: Bool = false) {
        self.exercise = exercise
        self.displayDetails = displayDetails && exercise.isTypeSet
        self.isIconAccented = isIconAccented
        self.accentColor = accentColor
        self.isFilled = isFilled
    }
    
    var body: some View {
        HStack {
            if isIconAccented {
                ExerciseTypeImage(type: exercise.type, isFilled: isFilled)
                    .font(.title.weight(.light))
                    .foregroundColor(accentColor)
            } else {
                ExerciseTypeImage(type: exercise.type)
                    .font(.title.weight(.light))
            }
            
            Text(exercise.name)
                    .fontWeight(.semibold)
            
            HStack {
                if displayDetails {
                    Spacer()
                    ExerciseDurationView(type: exercise.type, duration: exercise.duration)
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
                ExerciseShortDecorativeView(for: ExerciseTemplate.surjaNamascar)
                ExerciseShortDecorativeView(for: ExerciseTemplate.vasihsthasana)
                ExerciseShortDecorativeView(for: ExerciseTemplate.rest)
            }
            
            Group {
                Text("templates with durations")
                ExerciseShortDecorativeView(for: ExerciseTemplate.catCowNoDuration, displayDetails: true)
                ExerciseShortDecorativeView(for: ExerciseTemplate.catCow, displayDetails: true)
                ExerciseShortDecorativeView(for: ExerciseTemplate.surjaNamascar, displayDetails: true)
                ExerciseShortDecorativeView(for: ExerciseTemplate.vasihsthasana, displayDetails: true)
                ExerciseShortDecorativeView(for: ExerciseTemplate.catCowNoType, displayDetails: true)
                ExerciseShortDecorativeView(for: ExerciseTemplate.rest, displayDetails: true)
            }
            
            Group {
                Text("templates without durations")
                ExerciseShortDecorativeView(for: ExerciseTemplate.catCowNoDuration)
                ExerciseShortDecorativeView(for: ExerciseTemplate.catCow)
                ExerciseShortDecorativeView(for: ExerciseTemplate.surjaNamascar)
                ExerciseShortDecorativeView(for: ExerciseTemplate.vasihsthasana)
                ExerciseShortDecorativeView(for: ExerciseTemplate.catCowNoType)
                ExerciseShortDecorativeView(for: ExerciseTemplate.rest)
            }
        }
    }
}
