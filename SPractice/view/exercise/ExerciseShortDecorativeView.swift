//
//  ExerciseShortDecorativeView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 27.06.22.
//

import SwiftUI

struct ExerciseShortDecorativeView: View {
    
    private let exercise: ExerciseTemplate
    private var displayDuration = false
    
    init(for exercise: ExerciseTemplate, displayDuration: Bool = false) {
        self.exercise = exercise
        self.displayDuration = displayDuration
    }
    
    var duration: Int? {
        exercise.type == .tabata ? SettingsManager.shared.tabataExerciseDuration : exercise.duration
    }
    
    var body: some View {
        HStack {
            ExerciseTypeImage(type: exercise.type)
                .font(.title.weight(.light))
            
            VStack(alignment: .leading) {
                Text(exercise.name)
                    .fontWeight(.semibold)
                Text(exercise.intensityType?.rawValue ?? "?")
                        .foregroundColor(.secondary)
            }
            Spacer()
            if displayDuration {
                ExerciseDurationView(type: exercise.type, duration: duration)
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
                ExerciseShortDecorativeView(for: ExerciseTemplate.catCowDurationNoDuration, displayDuration: true)
                ExerciseShortDecorativeView(for: ExerciseTemplate.catCow, displayDuration: true)
                ExerciseShortDecorativeView(for: ExerciseTemplate.surjaNamascar, displayDuration: true)
                ExerciseShortDecorativeView(for: ExerciseTemplate.vasihsthasana, displayDuration: true)
                ExerciseShortDecorativeView(for: ExerciseTemplate.catCowNoType, displayDuration: true)
                ExerciseShortDecorativeView(for: ExerciseTemplate.rest, displayDuration: true)
            }
            
            Group {
                Text("templates without durations")
                ExerciseShortDecorativeView(for: ExerciseTemplate.catCowDurationNoDuration)
                ExerciseShortDecorativeView(for: ExerciseTemplate.catCow)
                ExerciseShortDecorativeView(for: ExerciseTemplate.surjaNamascar)
                ExerciseShortDecorativeView(for: ExerciseTemplate.vasihsthasana)
                ExerciseShortDecorativeView(for: ExerciseTemplate.catCowNoType)
                ExerciseShortDecorativeView(for: ExerciseTemplate.rest)
            }
        }
    }
}
