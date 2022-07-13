//
//  ExerciseTasksButton.swift
//  SPractice
//
//  Created by Yuliya Charniak on 13.07.22.
//

import SwiftUI

struct ExerciseTasksButton: View {
    
    var exercise: ExerciseTemplate
    
    @State private var showTasks = false
    
    var body: some View {
        Button("View tasks") {
            showTasks = true
        }
        .sheet(isPresented: $showTasks) {
            ExerciseEditorTasksView(exercise: practiceExercise)
        }
    }
    
    var practiceExercise: PracticeExercise {
        return PracticeExercise(from: exercise)!
    }
}

struct ExerciseTasksButton_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseTasksButton(exercise: ExerciseTemplate.vasihsthasana)
    }
}
