//
//  TaskDetailsShortView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 22.06.22.
//

import SwiftUI

struct TaskDetailsShortView: View {
    
    var task: Task
    
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
                    Image(systemName: "infinity")
                }
            }
            .foregroundColor(.gray)
        }
    }
}

struct TaskDetailsShortView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            TaskDetailsShortView(task: Task.activityTabata1)
            TaskDetailsShortView(task: Task.restTabata1)
            TaskDetailsShortView(task: Task.activity60)
            TaskDetailsShortView(task: Task.activityFlow)
            TaskDetailsShortView(task: Task.restService10)
        }
    }
}
