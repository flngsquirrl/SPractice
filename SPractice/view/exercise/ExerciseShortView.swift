//
//  ExerciseShortView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 7.06.22.
//

import SwiftUI

struct ExerciseShortView: View {
    
    private let name: String
    private let type: ExerciseType?
    private let taskType: IntensityType
    private let duration: Int?
    private let iconColor: Color
    
    private var displayDuration = false
    
    init(for exercise: PracticeExercise, iconColor: Color = .primary) {
        let taskType = exercise.type == .tabata ? .activity : exercise.tasks[0].type
        self.init(name: exercise.name, type: exercise.type, taskType: taskType, duration: exercise.duration, iconColor: iconColor)
        displayDuration = true
    }
    
    init(for template: Exercise, displayDuration: Bool = false, iconColor: Color = .primary) {
        var duration: Int? = nil
        if (displayDuration) {
            duration = template.type == .tabata ? SettingsManager.shared.tabataExerciseDuration : template.duration
        }
        self.init(name: template.name, type: template.type, taskType: template.intensityType, duration: duration, iconColor: iconColor)
        
        self.displayDuration = displayDuration
    }
    
    private init(name: String, type: ExerciseType?, taskType: IntensityType, duration: Int?, iconColor: Color) {
        self.name = name
        self.type = type
        self.taskType = taskType
        self.duration = duration
        self.iconColor = iconColor
    }
    
    var body: some View {
        HStack {
            ExerciseTypeImage(type: type)
                .foregroundColor(iconColor)
            Text(name)
            Spacer()
            HStack {
                if displayDuration {
                    ExerciseDurationView(type: type, duration: duration)
                }
                if let taskType = taskType {
                    IntensityTypeImage(type: taskType)
                }
            }
            .foregroundColor(.gray)
        }
    }
}

struct ExerciseShortView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            Group {
                Text("exercises")
                ExerciseShortView(for: PracticeExercise.catCow)
                ExerciseShortView(for: PracticeExercise.surjaNamascar)
                ExerciseShortView(for: PracticeExercise.vasihsthasana, iconColor: .lightOrange)
            }
            
            Group {
                Text("templates with durations")
                ExerciseShortView(for: Exercise.catCowDurationNoDuration, displayDuration: true)
                ExerciseShortView(for: Exercise.catCow, displayDuration: true)
                ExerciseShortView(for: Exercise.surjaNamascar, displayDuration: true, iconColor: .lightOrange)
                ExerciseShortView(for: Exercise.vasihsthasana, displayDuration: true)
                ExerciseShortView(for: Exercise.catCowNoType, displayDuration: true, iconColor: .lightOrange)
            }
            
            Group {
                Text("templates without durations")
                ExerciseShortView(for: Exercise.catCowDurationNoDuration, iconColor: .lightOrange)
                ExerciseShortView(for: Exercise.catCow)
                ExerciseShortView(for: Exercise.surjaNamascar)
                ExerciseShortView(for: Exercise.vasihsthasana)
                ExerciseShortView(for: Exercise.catCowNoType)
            }
        }
    }
}
