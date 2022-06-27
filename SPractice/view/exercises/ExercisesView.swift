//
//  ExercisesView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 8.06.22.
//

import SwiftUI

struct ExercisesView: View {
    
    @ObservedObject var exercisesManager = ExercisesManager.shared
    
    var body: some View {
        List {
            ForEach(exercisesManager.filteredExercises) { exercise in
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
        .searchable(text: $exercisesManager.searchText)
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
