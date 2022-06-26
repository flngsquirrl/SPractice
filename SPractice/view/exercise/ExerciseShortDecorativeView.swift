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
                Text(exercise.intensityType.rawValue)
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
                ExerciseShortView(for: PracticeExercise.catCow)
                ExerciseShortView(for: PracticeExercise.surjaNamascar)
                ExerciseShortView(for: PracticeExercise.vasihsthasana, iconColor: .lightOrange)
            }
            
            Group {
                Text("templates with durations")
                ExerciseShortView(for: Exercise.catCowDurationNoDuration, displayDuration: true)
                ExerciseShortView(for: Exercise.catCow, displayDuration: true)
                ExerciseShortView(for: Exercise.surjaNamascar, displayDuration: true, iconColor: .lightOrange)
                ExerciseShortView(for: Exercise.vasihsthasana, displayDuration: true)
                ExerciseShortView(for: Exercise.catCowNoType, displayDuration: true, iconColor: .lightOrange)
            }
            
            Group {
                Text("templates without durations")
                ExerciseShortView(for: Exercise.catCowDurationNoDuration, iconColor: .lightOrange)
                ExerciseShortView(for: Exercise.catCow)
                ExerciseShortView(for: Exercise.surjaNamascar)
                ExerciseShortView(for: Exercise.vasihsthasana)
                ExerciseShortView(for: Exercise.catCowNoType)
            }
        }
    }
}
