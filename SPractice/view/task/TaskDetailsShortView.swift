//
//  TaskDetailsShortView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 22.06.22.
//

import SwiftUI

struct TaskDetailsShortView: View {
    
    var task: Task
    var exerciseType: Exercise.ExerciseType
    
    var body: some View {
        HStack {
            TaskTypeImage(type: task.type)
            
            Text(task.name)
            Spacer()
            
            Group {
                if task.duration != nil {
                    Text(ClockTime.getPaddedPresentation(for: task.duration!))
                        .font(.system(.callout).monospacedDigit())
                } else {
                    if exerciseType == .flow {
                        Image(systemName: "infinity")
                    } else {
                        Image(systemName: "questionmark")
                    }
                }
            }
            .foregroundColor(.gray)
        }
    }
}

struct TaskDetailsShortView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            TaskDetailsShortView(task: Task.activityTabata1, exerciseType: .tabata)
            TaskDetailsShortView(task: Task.restTabata1, exerciseType: .tabata)
            TaskDetailsShortView(task: Task.activity60, exerciseType: .timer)
            TaskDetailsShortView(task: Task.activityFlow, exerciseType: .flow)
            TaskDetailsShortView(task: Task.restService10, exerciseType: .timer)
        }
    }
}
