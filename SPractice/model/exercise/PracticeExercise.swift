//
//  Exercise.swift
//  SPractice
//
//  Created by Yuliya Charniak on 28.04.22.
//

import Foundation

struct PracticeExercise: Exercise {

    let id = UUID()
    var type: ExerciseType?
    var name: String = ""
    var description: String = ""
    var intensity: Intensity?
    var isService: Bool = false

    var isExample: Bool = false
    var exampleId: String?

    var tasks: [Task] = []

    var unwrappedType: ExerciseType {
        type!
    }

    var duration: Duration {
        guard type != .flow else {
            return .unlimited
        }
        var result = 0
        tasks.forEach {
            if case .known(let duration) = $0.duration {
                result += duration
            }
        }
        return result > 0 ? .known(result) : .unknown
    }

    static let catCow = PracticeExercise(type: .flow, name: "Cat-Cow", description: "debug example", intensity: .activity, tasks: [Task.activity60])
}
