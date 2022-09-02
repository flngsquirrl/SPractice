//
//  ExerciseTasksButton.swift
//  SPractice
//
//  Created by Yuliya Charniak on 13.07.22.
//

import SwiftUI

struct ExerciseTasksButton: View {

    var tasks: [Task]

    @State private var showTasks = false

    var body: some View {
        Button("View tasks") {
            showTasks = true
        }
        .sheet(isPresented: $showTasks) {
            ExerciseTasksView(tasks: tasks)
        }
    }
}

struct ExerciseTasksButton_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseTasksButton(tasks: PracticeExercise(from: ExerciseTemplate.vasihsthasana)!.tasks)
    }
}
