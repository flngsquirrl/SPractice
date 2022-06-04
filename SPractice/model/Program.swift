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
    
    static let personal = Program(from: ProgramTemplate.personal)
    
    init(from template: ProgramTemplate) {
        self.name = template.name
        
        var exercises = [Exercise]()
        for (index, exerciseTemplate) in template.exercises.enumerated() {
            let exercise = Exercise(from: exerciseTemplate)
            exercises.append(exercise)
            
            if template.useRest && index != template.exercises.count - 1 {
                let rest = Exercise(from: ExerciseTemplate.restTemplate)
                exercises.append(rest)
            }
        }
        self.exercises = exercises
    }
    
    var wrappedDuration: String {
        var totalDuration = 0
        exercises.forEach {
            if let duration = $0.duration {
                totalDuration += duration
            }
        }
        return "\(totalDuration) sec"
    }
}
