//
//  ExerciseShortDecorativeView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 27.06.22.
//

import SwiftUI

struct ExerciseShortDecorativeView: View {
    
    private let exercise: Exercise
    private var displayDuration = false
    
    init(for exercise: Exercise, displayDuration: Bool = false) {
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
                ExerciseShortDecorativeView(for: Exercise.catCow)
                ExerciseShortDecorativeView(for: Exercise.surjaNamascar)
                ExerciseShortDecorativeView(for: Exercise.vasihsthasana)
                ExerciseShortDecorativeView(for: Exercise.rest)
            }
            
            Group {
                Text("templates with durations")
                ExerciseShortDecorativeView(for: Exercise.catCowDurationNoDuration, displayDuration: true)
                ExerciseShortDecorativeView(for: Exercise.catCow, displayDuration: true)
                ExerciseShortDecorativeView(for: Exercise.surjaNamascar, displayDuration: true)
                ExerciseShortDecorativeView(for: Exercise.vasihsthasana, displayDuration: true)
                ExerciseShortDecorativeView(for: Exercise.catCowNoType, displayDuration: true)
                ExerciseShortDecorativeView(for: Exercise.rest, displayDuration: true)
            }
            
            Group {
                Text("templates without durations")
                ExerciseShortDecorativeView(for: Exercise.catCowDurationNoDuration)
                ExerciseShortDecorativeView(for: Exercise.catCow)
                ExerciseShortDecorativeView(for: Exercise.surjaNamascar)
                ExerciseShortDecorativeView(for: Exercise.vasihsthasana)
                ExerciseShortDecorativeView(for: Exercise.catCowNoType)
                ExerciseShortDecorativeView(for: Exercise.rest)
            }
        }
    }
}
