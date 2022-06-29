//
//  ExercisesView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 8.06.22.
//

import SwiftUI

struct ExercisesView: View {
    
    @ObservedObject var exercisesManager = ExercisesManager.shared
    
    @State private var searchText = ""
    
    var filteredExercises: [ExerciseTemplate] {
        if searchText.isEmpty {
            return exercisesManager.exercises
        } else {
            return exercisesManager.exercises.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var sortedExercises: [ExerciseTemplate] {
        let sorted: [ExerciseTemplate] = filteredExercises.reversed()
        return sorted
    }
    
    var body: some View {
        List {
            ForEach(sortedExercises) { exercise in
                HStack {
                    NavigationLink {
                        ExerciseDetailsView(for: exercise) { exercisesManager.update(exercise: $0) }
                            onDelete: { exercisesManager.delete(exercise: $0) }
                    } label: {
                        ExerciseShortDecorativeView(for: exercise, displayDuration: exercise.type == .timer)
                    }
                }
            }
            .onDelete { exercisesManager.removeItems(at: $0) }
        }
        .searchable(text: $searchText)
        .disableAutocorrection(true)
    }
}

struct ExercisesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ExercisesView()
        }
    }
}
