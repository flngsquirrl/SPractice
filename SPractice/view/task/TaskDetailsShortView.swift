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
            IntensityImage(intensity: task.intensity)
            
            Text(task.name)
            Spacer()
            
            Group {
                switch task.duration {
                case .known(let time):
                    DurationView(duration: time, mode: .padded)
                case .unknown:
                    LayoutUtils.unknownDurationText
                case .unlimited:
                    LayoutUtils.unlimitedDurationImage
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
            TaskDetailsShortView(task: Task.restTimer, exerciseType: .timer)
        }
    }
}
