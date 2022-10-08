//
//  Program.swift
//  SPractice
//
//  Created by Yuliya Charniak on 5.07.22.
//

import Foundation

protocol Program: HavingID, Named {
    associatedtype Item where Item: Exercise

    var id: UUID {get}
    var name: String {get}
    var description: String {get}
    var exercises: [Item] {get}

    var isExample: Bool {get}
    var exampleId: String? {get}
}

extension Program {

    var hasExercises: Bool {
        !exercises.isEmpty
    }

    var hasFlowExercises: Bool {
        hasFlowExercises(fromIndex: 0)
    }

    func hasFlowExercises(fromIndex index: Int) -> Bool {
        let exercises = exercises[index...]
        return exercises.hasFlowExercises()
    }
}
