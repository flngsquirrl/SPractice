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
    private let duration: Duration
    
    private var displayDuration = false
    private var isIconAccented = false
    
    init(for exercise: Exercise, displayDuration: Bool = true, isIconAccented: Bool = false) {
        let taskType = exercise.tasks[0].type
        self.init(name: exercise.name, type: exercise.type, taskType: taskType, isService: exercise.isService, duration: exercise.duration, displayDuration: displayDuration, isIconAccented: isIconAccented)
    }
    
    init(for template: ExerciseTemplate, displayDuration: Bool = false, isIconAccented: Bool = false) {
        self.init(name: template.name, type: template.type, taskType: template.intensityType, isService: template.isService, duration: template.duration, displayDuration: displayDuration, isIconAccented: isIconAccented)
    }
    
    private init(name: String, type: ExerciseType?, taskType: IntensityType?, isService: Bool, duration: Duration, displayDuration: Bool = false, isIconAccented: Bool = false) {
        self.name = name
        self.type = type
        self.taskType = taskType
        self.isService = isService
        self.duration = duration
        self.displayDuration = displayDuration
        self.isIconAccented = isIconAccented
    }
    
    var body: some View {
        HStack {
            if isIconAccented {
                ExerciseTypeImage(type: type, isFilled: true)
                    .foregroundColor(.lightOrange)
            } else {
                ExerciseTypeImage(type: type)
            }
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
            .foregroundColor(.secondary)
        }
    }
}

struct ExerciseShortView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            Group {
                Text("exercises")
                ExerciseShortView(for: Exercise.catCow)
                ExerciseShortView(for: Exercise.surjaNamascar)
                ExerciseShortView(for: Exercise.vasihsthasana)
            }
            
            Group {
                Text("templates with durations")
                ExerciseShortView(for: ExerciseTemplate.catCowNoDuration, displayDuration: true)
                ExerciseShortView(for: ExerciseTemplate.catCow, displayDuration: true)
                ExerciseShortView(for: ExerciseTemplate.surjaNamascar, displayDuration: true)
                ExerciseShortView(for: ExerciseTemplate.vasihsthasana, displayDuration: true)
                ExerciseShortView(for: ExerciseTemplate.catCowNoType, displayDuration: true)
            }
            
            Group {
                Text("templates without durations")
                ExerciseShortView(for: ExerciseTemplate.catCowNoDuration)
                ExerciseShortView(for: ExerciseTemplate.catCow)
                ExerciseShortView(for: ExerciseTemplate.surjaNamascar)
                ExerciseShortView(for: ExerciseTemplate.vasihsthasana)
                ExerciseShortView(for: ExerciseTemplate.catCowNoType)
            }
            
            Group {
                Text("color test")
                ExerciseShortView(for: Exercise.catCow)
                    .foregroundColor(.secondary)
                ExerciseShortView(for: Exercise.catCow, isIconAccented: true)
            }
        }
    }
}
