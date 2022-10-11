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

    var mainController = ExercisesController.shared

    func isExampleExist(exampleId: String) -> Bool {
        mainController.listItems().contains {$0.exampleId == exampleId}
    }

    func getExample(exampleId: String) -> Item? {
        mainController.listItems().first {$0.exampleId == exampleId}
    }

    func restoreExample(_ item: Item) {
        mainController.addItem(prepareExample(from: item))
    }

    func resetExample(_ item: Item) {
        mainController.updateItem(item)
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

    var mainController = ProgramsController.shared

    func isExampleExist(exampleId: String) -> Bool {
        mainController.listItems().contains {$0.exampleId == exampleId}
    }

    func getExample(exampleId: String) -> Item? {
        defaultExamples.first {$0.exampleId == exampleId}
    }

    func restoreExample(_ item: Item) {
        mainController.addItem(prepareExample(from: item))
    }

    func resetExample(_ item: Item) {
        mainController.updateItem(item)
    }

    func prepareExample(from template: Item) -> Item {
        ProgramTemplate(from: template)
    }

    var defaultExamples: [Item] {
        [.simpleYoga, .simpleWorkout]
    }
}
