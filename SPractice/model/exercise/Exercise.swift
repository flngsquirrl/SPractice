//
//  Exercise.swift
//  SPractice
//
//  Created by Yuliya Charniak on 5.07.22.
//

import Foundation

protocol Exercise: HavingID, Named {
    var id: UUID {get}
    var name: String {get}
    var description: String {get}
    var type: ExerciseType? {get}
    var duration: Duration? {get}
    var intensity: Intensity? {get}
    var isService: Bool {get}
}

protocol ExampleExercise: Exercise, ExampleItem {}

extension Exercise {
    var isTimer: Bool {
        type == .timer
    }

    var isTypeSet: Bool {
        type != nil
    }
}
