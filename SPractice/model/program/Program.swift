//
//  Program.swift
//  SPractice
//
//  Created by Yuliya Charniak on 28.04.22.
//

import Foundation

struct Program {
    
    let id = UUID()
    let name: String
    let exercises: [Exercise]
    
    init(from template: ProgramTemplate, useRest: Bool = false) {
        self.name = template.name
        
        var exercises = [Exercise]()
        for (index, exerciseTemplate) in template.exercises.enumerated() {
            let exercise = Exercise(from: exerciseTemplate)
            exercises.append(exercise!)
            
            if useRest && index != template.exercises.count - 1 {
                let rest = Exercise(from: ExerciseTemplate.restTemplate)
                exercises.append(rest!)
            }
        }
        self.exercises = exercises
    }
    
    var duration: Int? {
        calculateDuration(from: 0)
    }
    
    func calculateDuration(from exerciseIndex: Int) -> Int? {
        var totalDuration = 0
        for i in exerciseIndex..<exercises.count {
            if let duration = exercises[i].duration {
                totalDuration += duration
            }
        }
        return totalDuration == 0 ? nil : totalDuration
    }
    
    // examples
    static let personal = Program(from: ProgramTemplate.personal)
}
