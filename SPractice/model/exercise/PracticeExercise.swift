//
//  Exercise.swift
//  SPractice
//
//  Created by Yuliya Charniak on 28.04.22.
//

import Foundation

struct PracticeExercise: Exercise {

    let template: ExerciseTemplate

    init(template: ExerciseTemplate) {
        self.template = template
    }

    var id: UUID {
        template.id
    }

    var name: String {
        template.name
    }

    var description: String {
        template.description
    }

    var type: ExerciseType? {
        template.type
    }

    var intensity: Intensity? {
        template.intensity
    }

    var isService: Bool {
        template.isService
    }

    var isExample: Bool {
        template.isExample
    }

    var exampleId: String? {
        template.exampleId
    }

    var tasks: [Task] = []

    var unwrappedType: ExerciseType {
        type!
    }

    var unwrappedDuration: Duration {
        duration!
    }

    var duration: Duration? {
        guard type != .flow else {
            return .unlimited
        }
        var result = 0
        tasks.forEach {
            if case .known(let duration) = $0.duration {
                result += duration
            }
        }
        return .known(result)
    }
}

extension PracticeExercise {
    static let catCow = PracticeExercise(template: ExerciseTemplate.catCow)
}
