//
//  ExerciseManager.swift
//  SPractice
//
//  Created by Yuliya Charniak on 26.06.22.
//

import Foundation

@MainActor class ExercisesManager: ObservableObject {
    
    @Published var exercises = [ExerciseTemplate.catCow, ExerciseTemplate.surjaNamascar, ExerciseTemplate.vasihsthasana, ExerciseTemplate.concentration, ExerciseTemplate.catCowDurationNoDuration, ExerciseTemplate.catCowNoType]
    
    static let shared = ExercisesManager()
    
    @Published var searchText = ""
    
    private init() {
        for _ in 1...100 {
            exercises.append(ExerciseTemplate(from: ExerciseTemplate.catCow))
        }
    }
    
    var filteredExercises: [ExerciseTemplate] {
        if searchText.isEmpty {
            return exercises
        } else {
            return exercises.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    func addNew(exercise: ExerciseTemplate) {
        exercises.append(exercise)
    }
    
    func removeItems(at offsets: IndexSet) {
        exercises.remove(atOffsets: offsets)
    }
    
    func update(exercise: ExerciseTemplate) {
        if let index = exercises.firstIndex(where: {$0.id == exercise.id}) {
            exercises[index] = exercise
        }
    }
    
    func delete(exercise: ExerciseTemplate) {
        if let index = exercises.firstIndex(where: {$0.id == exercise.id}) {
            exercises.remove(at: index)
        }
    }
}
