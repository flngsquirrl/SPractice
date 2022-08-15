//
//  ExerciseDetailsContent.swift
//  SPractice
//
//  Created by Yuliya Charniak on 11.08.22.
//

import SwiftUI

struct ExerciseDetailsContent<T>: View where T: Exercise {
    
    var exercise: T
    
    var body: some View {
        Section {
            HStack(alignment: .center) {
                if exercise.isExample {
                    SquirrelIcon()
                }
                Text(exercise.name)
                    .fontWeight(.semibold)
            }
            if showDescription {
                Text(exercise.description)
                    .foregroundColor(.secondary)
            }
        } footer: {
            if exercise.isExample {
                HStack(spacing: 0) {
                    Text("This is an example ")
                    InfoButton()
                }
            }
        }
        
        Section {
            HStack {
                Text("Type")
                InfoButton()
                Spacer()
                ExerciseTypeView(type: exercise.type, mode: .iconAndText)
                    .foregroundColor(.secondary)
            }
            
            if showDetails {
                HStack {
                    Text("Duration")
                    InfoButton()
                    Spacer()
                    ExerciseDurationView(for: exercise, isVerbose: true)
                        .foregroundColor(.secondary)
                }
            
                HStack {
                    Text("Intensity")
                    InfoButton()
                    Spacer()
                    IntensityView(intensity: exercise.intensity, mode: .iconAndText)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
    
    var showDetails: Bool {
        exercise.isTypeSet
    }
    
    var showDescription: Bool {
        !exercise.description.isEmptyString
    }
}

struct ExerciseDetailsContent_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseDetailsContent(exercise: PracticeExercise(from: ExerciseTemplate.catCow)!)
    }
}
