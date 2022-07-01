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
    
    init(from template: ProgramTemplate) {
        self.name = template.name
        
        var exercises = [Exercise]()
        for exerciseTemplate in template.exercises {
            let exercise = Exercise(from: exerciseTemplate)
            exercises.append(exercise!)
        }
        self.exercises = exercises
    }
    
    var duration: Int? {
        calculateDuration(fromIndex: 0)
    }
    
    func calculateDuration(fromIndex index: Int) -> Int? {
        var totalDuration = 0
        for i in index..<exercises.count {
            if let duration = exercises[i].duration {
                totalDuration += duration
            }
        }
        return totalDuration == 0 ? nil : totalDuration
    }
    
    // examples
    static let personal = Program(from: ProgramTemplate.personal)
}
