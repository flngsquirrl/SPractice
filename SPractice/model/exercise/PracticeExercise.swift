//
//  Exercise.swift
//  SPractice
//
//  Created by Yuliya Charniak on 28.04.22.
//

import Foundation

struct PracticeExercise: Exercise {

    let id = UUID()
    let exerciseType: ExerciseType
    let name: String
    let description: String
    var exerciseIntensity: Intensity
    var isService: Bool

    var isExample: Bool
    var exampleId: String?

    var tasks: [Task]

        self.exerciseType = type
    init(type: ExerciseType, name: String, description: String, intensity: Intensity, isService: Bool = false,
         isExample: Bool = false, exampleId: String? = nil, tasks: [Task] = []) {
        self.name = name.trim()
        self.description = description.trim()
        self.exerciseIntensity = intensity
        self.isService = isService
        self.isExample = isExample
        self.exampleId = exampleId
        self.tasks = tasks
    }

    var duration: Duration {
        guard exerciseType != .flow else {
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
