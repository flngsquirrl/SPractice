//
//  ExerciseManager.swift
//  SPractice
//
//  Created by Yuliya Charniak on 26.06.22.
//

import Foundation

@MainActor class Exercises: ObservableObject, PersistentDataManager {
    
    //@Published internal var items: [ExerciseTemplate] = [ExerciseTemplate.catCow, ExerciseTemplate.balasana, ExerciseTemplate.shavasana, ExerciseTemplate.vasihsthasana, ExerciseTemplate.catCowNoDuration, ExerciseTemplate.surjaNamascarA, ExerciseTemplate.catCowNoType]
    
    @Published internal var items: [ExerciseTemplate]
    
    static let shared = Exercises()
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent("Exercises")

    private init() {
//        do {
//            let data = try Data(contentsOf: savePath)
//            templates = try JSONDecoder().decode([ExerciseTemplate].self, from: data)
//        } catch {
//            templates = []
//        }
        
//        for lots of items
//
       let templates = [ExerciseTemplate.catCow, ExerciseTemplate.balasana, ExerciseTemplate.shavasana, ExerciseTemplate.vasihsthasana, ExerciseTemplate.catCowNoDuration, ExerciseTemplate.surjaNamascarA, ExerciseTemplate.catCowNoType]
        var exercises: [ExerciseTemplate] = []
        for template in templates {
            for i in 1...25 {
                var exercise = ExerciseTemplate(from: template)
                exercise.name += " \(i)"
                exercises.append(exercise)
            }
        }
        
        items = exercises
    }
    
    internal func save() {
//        do {
//            let data = try JSONEncoder().encode(templates)
//            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
//        } catch {
//            print("Unable to save data.")
//        }
    }
}
