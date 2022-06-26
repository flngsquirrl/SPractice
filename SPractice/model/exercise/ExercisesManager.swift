//
//  ExerciseManager.swift
//  SPractice
//
//  Created by Yuliya Charniak on 26.06.22.
//

import Foundation

@MainActor class ExercisesManager: ObservableObject {
    
    @Published var exercises = [Exercise.catCow, Exercise.surjaNamascar, Exercise.vasihsthasana, Exercise.concentration, Exercise.catCowDurationNoDuration, Exercise.catCowNoType]
    
    static let shared = ExercisesManager()
    
    @Published var searchText = ""
    
    private init() {
    }
    
    var filteredExercises: [Exercise] {
        if searchText.isEmpty {
            return exercises
        } else {
            return exercises.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    func addNew(exercise: Exercise) {
        exercises.append(exercise)
    }
    
    func removeItems(at offsets: IndexSet) {
        exercises.remove(atOffsets: offsets)
    }
    
    func moveItems(from fromOffsets: IndexSet, to toOffsets: Int) {
        exercises.move(fromOffsets: fromOffsets, toOffset: toOffsets)
    }
    
    func update(exercise: Exercise) {
        if let index = exercises.firstIndex(where: {$0.id == exercise.id}) {
            exercises[index] = exercise
        }
    }
    
    func delete(exercise: Exercise) {
        if let index = exercises.firstIndex(where: {$0.id == exercise.id}) {
            exercises.remove(at: index)
        }
    }
}
