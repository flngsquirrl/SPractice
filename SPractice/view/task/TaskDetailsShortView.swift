//
//  TaskDetailsShortView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 22.06.22.
//

import SwiftUI

struct TaskDetailsShortView: View {
    
    var task: Task
    var exerciseType: ExerciseType
    
    var body: some View {
        HStack {
            IntensityTypeImage(type: task.type)
            
            Text(task.name)
            Spacer()
            
            Group {
                if task.duration != nil {
                    DurationView(duration: task.duration!, mode: .padded)
                        .font(LayoutUtils.timeFont)
                } else {
                    if exerciseType == .flow {
                        LayoutUtils.unlimitedDurationImage
                    } else {
                        LayoutUtils.unknownDurationImage
                    }
                }
            }
            .foregroundColor(.secondary)
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
