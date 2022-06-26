//
//  Program.swift
//  SPractice
//
//  Created by Yuliya Charniak on 28.04.22.
//

import Foundation

struct PracticeProgram {
    
    let id = UUID()
    let name: String
    let exercises: [PracticeExercise]
    
    static let personal = PracticeProgram(from: Program.personal)
    
    init(from template: Program, useRest: Bool = false) {
        self.name = template.name
        
        var exercises = [PracticeExercise]()
        for (index, exerciseTemplate) in template.exercises.enumerated() {
            let exercise = PracticeExercise(from: exerciseTemplate)
            exercises.append(exercise!)
            
            if useRest && index != template.exercises.count - 1 {
                let rest = PracticeExercise(from: Exercise.restTemplate)
                exercises.append(rest!)
            }
        }
        self.exercises = exercises
    }
    
    var duration: Int? {
        var totalDuration = 0
        var hasDuration = false
        exercises.forEach {
            if let duration = $0.duration {
                totalDuration += duration
                hasDuration = true
            }
        }
        return hasDuration ? totalDuration : nil
    }
}
