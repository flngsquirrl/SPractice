//
//  ExerciseShortView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 7.06.22.
//

import SwiftUI

struct ExerciseShortView<E: Exercise, Icon: View>: View {
    
    @ObservedObject var settings = SettingsManager.settings
    
    private let exercise: E
    private var displayDetails = false
    @ViewBuilder private var icon: Icon
    
    init(for exercise: E, displayDetails: Bool = true, icon: () -> Icon) {
        self.exercise = exercise
        self.displayDetails = displayDetails && exercise.isTypeSet
        self.icon = icon()
    }
    
    var body: some View {
        HStack {
            icon
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
            return SettingsManager.restName
        }
        return exercise.name
    }
}

struct ExerciseShortView_Previews: PreviewProvider {
    static var previews: some View {
        List {
//            Group {
//                Text("exercises")
//                ExerciseShortView(for: PracticeExercise.catCow)
//                ExerciseShortView(for: PracticeExercise.surjaNamascarA)
//                ExerciseShortView(for: PracticeExercise.vasihsthasana)
//            }
//
//            Group {
//                Text("templates with durations")
//                ExerciseShortView(for: ExerciseTemplate.catCowNoDuration, displayDetails: true)
//                ExerciseShortView(for: ExerciseTemplate.catCow, displayDetails: true)
//                ExerciseShortView(for: ExerciseTemplate.surjaNamascarA, displayDetails: true)
//                ExerciseShortView(for: ExerciseTemplate.vasihsthasana, displayDetails: true)
//                ExerciseShortView(for: ExerciseTemplate.catCowNoType, displayDetails: true)
//            }
//
//            Group {
//                Text("templates without durations")
//                ExerciseShortView(for: ExerciseTemplate.catCowNoDuration)
//                ExerciseShortView(for: ExerciseTemplate.catCow)
//                ExerciseShortView(for: ExerciseTemplate.surjaNamascarA)
//                ExerciseShortView(for: ExerciseTemplate.vasihsthasana)
//                ExerciseShortView(for: ExerciseTemplate.catCowNoType)
//            }
            
            Group {
                Text("icon test")
                ExerciseShortView(for: PracticeExercise.catCow) {
                    ExerciseTypeImage(type: .flow)
                }
                .foregroundColor(.secondary)
                ExerciseShortView(for: PracticeExercise.catCow) {
                    ExerciseTypeImage(type: .flow)
                }
            }
        }
    }
}
