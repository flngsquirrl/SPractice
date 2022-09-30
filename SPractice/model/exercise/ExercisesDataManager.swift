//
//  ExercisesDataManager.swift
//  SPractice
//
//  Created by Yuliya Charniak on 26.06.22.
//

import Foundation

@MainActor class ExercisesDataManager: ObservableObject, PersistentDataManager {

    @Published internal var items: [ExerciseTemplate]

    let savePath = FileManager.documentsDirectory.appendingPathComponent("Exercises")

    init() {
        do {
            let data = try Data(contentsOf: savePath)
            items = try JSONDecoder().decode([ExerciseTemplate].self, from: data)
        } catch {
            items = ExerciseTemplate.defaultExamples
        }

//        for lots of items
//
//       let templates = [ExerciseTemplate.catCow, ExerciseTemplate.balasana, ExerciseTemplate.shavasana, ExerciseTemplate.vasisthasana, ExerciseTemplate.catCowNoDuration, ExerciseTemplate.surjaNamascarA, ExerciseTemplate.catCowNoType]
//        var exercises: [ExerciseTemplate] = []
//        for template in templates {
//            for i in 1...25 {
//                var exercise = ExerciseTemplate(from: template)
//                exercise.name += " \(i)"
//                exercises.append(exercise)
//            }
//        }
//
//        items = exercises
    }

    internal func save() {
        do {
            let data = try JSONEncoder().encode(items)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
}
