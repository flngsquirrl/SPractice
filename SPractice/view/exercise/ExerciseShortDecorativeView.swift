//
//  ExerciseShortDecorativeView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 27.06.22.
//

import SwiftUI

struct ExerciseShortDecorativeView: View {
    
    private let exercise: ExerciseTemplate
    private var displayDuration: Bool
    
    init(for exercise: ExerciseTemplate, displayDuration: Bool = true) {
        self.exercise = exercise
        self.displayDuration = displayDuration
    }
    
    var body: some View {
        HStack {
            ExerciseTypeImage(type: exercise.type)
                .font(.title.weight(.light))
            
            VStack(alignment: .leading) {
                Text(exercise.name)
                    .fontWeight(.semibold)
                HStack(spacing: 0) {
                    Text("intensity: ")
                    IntensityView(intensity: exercise.intensity, mode: .text)
                }
                .foregroundColor(.secondary)
            }
            Spacer()
            if displayDuration {
                ExerciseDurationView(type: exercise.type, duration: exercise.duration)
                    .foregroundColor(.secondary)
            }
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
                ExerciseShortDecorativeView(for: ExerciseTemplate.catCowNoDuration, displayDuration: true)
                ExerciseShortDecorativeView(for: ExerciseTemplate.catCow, displayDuration: true)
                ExerciseShortDecorativeView(for: ExerciseTemplate.surjaNamascar, displayDuration: true)
                ExerciseShortDecorativeView(for: ExerciseTemplate.vasihsthasana, displayDuration: true)
                ExerciseShortDecorativeView(for: ExerciseTemplate.catCowNoType, displayDuration: true)
                ExerciseShortDecorativeView(for: ExerciseTemplate.rest, displayDuration: true)
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
