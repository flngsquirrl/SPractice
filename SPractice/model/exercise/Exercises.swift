//
//  ExerciseManager.swift
//  SPractice
//
//  Created by Yuliya Charniak on 26.06.22.
//

import Foundation

@MainActor class Exercises: ObservableObject {
    
    @Published var templates: [ExerciseTemplate] = [ExerciseTemplate.catCow, ExerciseTemplate.balasana, ExerciseTemplate.concentration, ExerciseTemplate.vasihsthasana, ExerciseTemplate.catCowNoDuration, ExerciseTemplate.surjaNamascar, ExerciseTemplate.catCowNoType]
    
    static let shared = Exercises()
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent("Exercises")

    private init() {
//        do {
//            let data = try Data(contentsOf: savePath)
//            templates = try JSONDecoder().decode([ExerciseTemplate].self, from: data)
//        } catch {
//            templates = []
//        }
    }
    
    private func save() {
//        do {
//            let data = try JSONEncoder().encode(templates)
//            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
//        } catch {
//            print("Unable to save data.")
//        }
    }
    
    func addNew(_ exercise: ExerciseTemplate) {
        templates.append(exercise)
        save()
    }
    
    func removeItems(at offsets: IndexSet) {
        templates.remove(atOffsets: offsets)
        save()
    }
    
    func update(_ exercise: ExerciseTemplate) {
        if let index = templates.firstIndex(where: {$0.id == exercise.id}) {
            templates[index] = exercise
            save()
        }
    }
    
    func delete(_ exercise: ExerciseTemplate) {
        if let index = templates.firstIndex(where: {$0.id == exercise.id}) {
            templates.remove(at: index)
            save()
        }
    }
    
    func contains(_ program: ExerciseTemplate) -> Bool {
        templates.firstIndex(where: {$0.id == program.id}) != nil
    }
}
