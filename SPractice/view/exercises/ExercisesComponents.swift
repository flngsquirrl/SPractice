//
//  ExercisesComponents.swift
//  SPractice
//
//  Created by Yuliya Charniak on 19.10.22.
//

import Foundation

struct ExercisesComponents: ListComponentsProvider {

    typealias Item = ExerciseTemplate

    var title: String {
        "Exercises"
    }

    var addItemView: AddExerciseView {
        AddExerciseView()
    }

    func getShortView(item: ExerciseTemplate, isAccented: Bool) -> ExerciseShortDecorativeView {
        return ExerciseShortDecorativeView(for: item, isAccented: isAccented)
    }

    func getDetailsView(item: ExerciseTemplate) -> ExerciseDetailsView {
        ExerciseDetailsView(for: item)
    }
}
