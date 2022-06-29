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
    private let taskType: IntensityType?
    private let isService: Bool
    private let duration: Int?
    
    private var displayDuration = false
    
    init(for exercise: PracticeExercise) {
        let taskType = exercise.type == .tabata ? .activity : exercise.tasks[0].type
        self.init(name: exercise.name, type: exercise.type, taskType: taskType, isService: exercise.isService, duration: exercise.duration)
        displayDuration = true
    }
    
    init(for exercise: Exercise, displayDuration: Bool = false) {
        var duration: Int? = nil
        if (displayDuration) {
            duration = exercise.type == .tabata ? SettingsManager.shared.tabataExerciseDuration : exercise.duration
        }
        self.init(name: exercise.name, type: exercise.type, taskType: exercise.intensityType, isService: exercise.isService, duration: duration)
        
        self.displayDuration = displayDuration
    }
    
    private init(name: String, type: ExerciseType?, taskType: IntensityType?, isService: Bool, duration: Int?) {
        self.name = name
        self.type = type
        self.taskType = taskType
        self.isService = isService
        self.duration = duration
    }
    
    var body: some View {
        HStack {
            ExerciseTypeImage(type: type)
                .foregroundColor(isService ? .secondary : .primary)
            Text(name)
                .foregroundColor(isService ? .secondary : .primary)
            Spacer()
            HStack {
                if displayDuration {
                    ExerciseDurationView(type: type, duration: duration)
                }
                if let taskType = taskType {
                    IntensityTypeImage(type: taskType)
                }
            }
            .foregroundColor(.secondary)
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
                ExerciseShortView(for: PracticeExercise.vasihsthasana)
            }
            
            Group {
                Text("templates with durations")
                ExerciseShortView(for: Exercise.catCowDurationNoDuration, displayDuration: true)
                ExerciseShortView(for: Exercise.catCow, displayDuration: true)
                ExerciseShortView(for: Exercise.surjaNamascar, displayDuration: true)
                ExerciseShortView(for: Exercise.vasihsthasana, displayDuration: true)
                ExerciseShortView(for: Exercise.catCowNoType, displayDuration: true)
            }
            
            Group {
                Text("templates without durations")
                ExerciseShortView(for: Exercise.catCowDurationNoDuration)
                ExerciseShortView(for: Exercise.catCow)
                ExerciseShortView(for: Exercise.surjaNamascar)
                ExerciseShortView(for: Exercise.vasihsthasana)
                ExerciseShortView(for: Exercise.catCowNoType)
            }
        }
    }
}
