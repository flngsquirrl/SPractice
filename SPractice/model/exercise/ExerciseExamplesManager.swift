//
//  ExerciseExamplesManager.swift
//  SPractice
//
//  Created by Yuliya Charniak on 10.10.22.
//

import Foundation
import Resolver

class ExerciseExamplesManager: ExamplesManager {

    typealias Item = ExerciseTemplate

    var mainManager = ExercisesManager.shared

    func isExampleExist(exampleId: String) -> Bool {
        mainManager.listItems().contains {$0.exampleId == exampleId}
    }

    func getExample(exampleId: String) -> Item? {
        mainManager.listItems().first {$0.exampleId == exampleId}
    }

    func restoreExample(_ item: Item) {
        mainManager.addItem(prepareExample(from: item))
    }

    func resetExample(_ item: Item) {
        mainManager.updateItem(item)
    }

    func prepareExample(from template: Item) -> Item {
        ExerciseTemplate(from: template)
    }

    var defaultExamples: [Item] {
        [.catCow, .surjaNamascarA, .balasana, .vasisthasana, .shavasana, .plank, .squats, .jumpRope]
    }
}

class ProgramExamplesManager: ExamplesManager {

    typealias Item = ProgramTemplate

    var mainManager = ProgramsManager()

    func isExampleExist(exampleId: String) -> Bool {
        mainManager.listItems().contains {$0.exampleId == exampleId}
    }

    func getExample(exampleId: String) -> Item? {
        defaultExamples.first {$0.exampleId == exampleId}
    }

    func restoreExample(_ item: Item) {
        mainManager.addItem(prepareExample(from: item))
    }

    func resetExample(_ item: Item) {
        mainManager.updateItem(item)
    }

    func prepareExample(from template: Item) -> Item {
        ProgramTemplate(from: template)
    }

    var defaultExamples: [Item] {
        [.simpleYoga, .simpleWorkout]
    }
}
