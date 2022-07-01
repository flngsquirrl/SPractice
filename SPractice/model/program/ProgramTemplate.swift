//
//  ProgramTemplate.swift
//  SPractice
//
//  Created by Yuliya Charniak on 29.04.22.
//

import Foundation

struct ProgramTemplate: Identifiable, Codable {
    
    var id: UUID
    var name: String
    var exercises = [ExerciseTemplate]()
    
    init(id: UUID = UUID(), name: String = "", exercises: [ExerciseTemplate] = []) {
        self.id = id
        self.name = name
        self.exercises = exercises
    }
    
    init(from template: ProgramTemplate, useRest: Bool = false) {
        var exercises = [ExerciseTemplate]()
        for (index, exerciseTemplate) in template.exercises.enumerated() {
            let exercise = ExerciseTemplate(from: exerciseTemplate)
            exercises.append(exercise)
            
            if useRest && index != template.exercises.count - 1 {
                exercises.append(ExerciseTemplate.restTemplate)
            }
        }
        self.init(name: template.name, exercises: exercises)
    }
    
    var hasExercises: Bool {
        !exercises.isEmpty
    }
    
    var duration: Duration {
        calculateDuration(fromIndex: 0)
    }
    
    func calculateDuration(fromIndex index: Int) -> Duration {
        var totalDuration = 0
        for i in index..<exercises.count {
            if case .known(let duration) = exercises[i].duration {
                totalDuration += duration
            }
        }
        return totalDuration == 0 ? (hasFlowExercises(fromIndex: index) ? .unlimited : .unknown) : .known(totalDuration)
    }
    
    var hasFlowExercises: Bool {
        hasFlowExercises(fromIndex: 0)
    }
    
    func hasFlowExercises(fromIndex index: Int) -> Bool {
        let subrange = Array(exercises[index...])
        let exerciseMissingDuration = subrange.first(where: {
            $0.type == .flow
        })
        return exerciseMissingDuration != nil
    }
    
    var hasExercisesMissingDuration: Bool {
        let exerciseMissingDuration = exercises.first(where: {
            if case .unknown = $0.duration {
                return true
            } else {
                return false
            }
        })
        return exerciseMissingDuration != nil
    }
    
    static var template: ProgramTemplate {
        ProgramTemplate()
    }
    
    // examples
    static let personal = ProgramTemplate(name: "Personal", exercises: [ExerciseTemplate.catCow, ExerciseTemplate.surjaNamascar, ExerciseTemplate.vasihsthasana])
    static let dailyShort = ProgramTemplate(name: "Daily short", exercises: [ExerciseTemplate.concentration, ExerciseTemplate.catCow])
    static let shortForBack = ProgramTemplate(name: "Short for back", exercises: [ExerciseTemplate.catCow])
}
