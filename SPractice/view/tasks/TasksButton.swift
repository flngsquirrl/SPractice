//
//  TasksButton.swift
//  SPractice
//
//  Created by Yuliya Charniak on 13.07.22.
//

import SwiftUI

struct TasksButton: View {

    var tasks: [Task]

    @State private var showTasks = false

    var body: some View {
        Button("View tasks") {
            showTasks = true
        }
        .sheet(isPresented: $showTasks) {
            TasksView(tasks: tasks)
        }
    }
}

struct TasksButton_Previews: PreviewProvider {
    static var previews: some View {
        TasksButton(tasks: [Task.restTabataWarmUp, Task.activityTabata1,
                            Task.restTabata1, Task.restTabataCoolDown])
    }
}
