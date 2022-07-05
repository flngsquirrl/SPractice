//
//  ExerciseShortView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 7.06.22.
//

import SwiftUI

struct ExerciseShortView<T>: View where T: Exercise {
    
    private let exercise: T
    private var displayDuration = false
    private var isIconAccented = false
    
    init(for exercise: T, displayDuration: Bool = true, isIconAccented: Bool = false) {
        self.exercise = exercise
        self.displayDuration = displayDuration
        self.isIconAccented = isIconAccented
    }
    
    var body: some View {
        HStack {
            if isIconAccented {
                ExerciseTypeImage(type: exercise.type, isFilled: true)
                    .foregroundColor(.lightOrange)
            } else {
                ExerciseTypeImage(type: exercise.type)
            }
            Text(exercise.name)
            Spacer()
            HStack {
                if displayDuration {
                    ExerciseDurationView(type: exercise.type, duration: exercise.duration)
                }
                IntensityView(intensity: exercise.intensity)
            }
            .foregroundColor(.secondary)
        }
    }
}

struct ExerciseShortView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            Group {
                Text("exercises")
                ExerciseShortView(for: PracticeExercise.catCow)
                ExerciseShortView(for: PracticeExercise.surjaNamascar)
                ExerciseShortView(for: PracticeExercise.vasihsthasana)
            }
            
            Group {
                Text("templates with durations")
                ExerciseShortView(for: ExerciseTemplate.catCowNoDuration, displayDuration: true)
                ExerciseShortView(for: ExerciseTemplate.catCow, displayDuration: true)
                ExerciseShortView(for: ExerciseTemplate.surjaNamascar, displayDuration: true)
                ExerciseShortView(for: ExerciseTemplate.vasihsthasana, displayDuration: true)
                ExerciseShortView(for: ExerciseTemplate.catCowNoType, displayDuration: true)
            }
            
            Group {
                Text("templates without durations")
                ExerciseShortView(for: ExerciseTemplate.catCowNoDuration)
                ExerciseShortView(for: ExerciseTemplate.catCow)
                ExerciseShortView(for: ExerciseTemplate.surjaNamascar)
                ExerciseShortView(for: ExerciseTemplate.vasihsthasana)
                ExerciseShortView(for: ExerciseTemplate.catCowNoType)
            }
            
            Group {
                Text("color test")
                ExerciseShortView(for: PracticeExercise.catCow)
                    .foregroundColor(.secondary)
                ExerciseShortView(for: PracticeExercise.catCow, isIconAccented: true)
            }
        }
    }
}
