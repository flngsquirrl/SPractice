//
//  ExerciseShortView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 7.06.22.
//

import SwiftUI

struct ExerciseShortView<T>: View where T: Exercise {
    
    @EnvironmentObject var settings: Settings
    
    private let exercise: T
    private var displayDetails = false
    private var isIconAccented = false
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
                ExerciseTypeImage(type: exercise.type, isFilled: true)
                    .foregroundColor(accentColor)
            } else {
                ExerciseTypeImage(type: exercise.type)
            }
            Text(name)
            
            if displayDetails {
                Spacer()
                Group {
                    ExerciseDurationView(for: exercise)
                    IntensityView(intensity: exercise.intensity)
                }
                .foregroundColor(.secondary)
            }
        }
    }
    
    var name: String {
        if exercise.isService {
            return SettingsManager.pauseName
        }
        return exercise.name
    }
}

struct ExerciseShortView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            Group {
                Text("exercises")
                ExerciseShortView(for: PracticeExercise.catCow)
                ExerciseShortView(for: PracticeExercise.surjaNamascarA)
                ExerciseShortView(for: PracticeExercise.vasihsthasana)
            }
            
            Group {
                Text("templates with durations")
                ExerciseShortView(for: ExerciseTemplate.catCowNoDuration, displayDetails: true)
                ExerciseShortView(for: ExerciseTemplate.catCow, displayDetails: true)
                ExerciseShortView(for: ExerciseTemplate.surjaNamascarA, displayDetails: true)
                ExerciseShortView(for: ExerciseTemplate.vasihsthasana, displayDetails: true)
                ExerciseShortView(for: ExerciseTemplate.catCowNoType, displayDetails: true)
            }
            
            Group {
                Text("templates without durations")
                ExerciseShortView(for: ExerciseTemplate.catCowNoDuration)
                ExerciseShortView(for: ExerciseTemplate.catCow)
                ExerciseShortView(for: ExerciseTemplate.surjaNamascarA)
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
