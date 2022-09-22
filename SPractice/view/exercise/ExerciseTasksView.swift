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
        NavigationStack {
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
        .accentColor(.customAccentColor)
    }
}

struct ExerciseTasksView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseTasksView(tasks: [Task.restTabataWarmUp, Task.activityTabata1,
                                  Task.restTabata1, Task.restTabataCoolDown])
    }
}
