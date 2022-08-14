//
//  ExerciseTasksView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 2.07.22.
//

import SwiftUI

struct ExerciseTasksView: View {
    
    var tasks: [Task]
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            List(tasks) { task in
                TaskDetailsShortView(task: task)
            }
            .navigationTitle("Tasks")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
        .accentColor(.customAccentColor)
    }
}

struct ExerciseTasksView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseTasksView(tasks: PracticeExercise.vasihsthasana.tasks)
    }
}
