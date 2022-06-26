//
//  ExercisesView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 8.06.22.
//

import SwiftUI

struct ExercisesView: View, EditableView {
    
    @Environment(\.editMode) var editMode
    
    @ObservedObject var exercisesManager = ExercisesManager.shared
    
    var body: some View {
        List {
            ForEach(exercisesManager.filteredExercises) { exercise in
                HStack {
                    if isInEditMode {
                        ExerciseDetailsShortView(for: exercise, displayDuration: exercise.type == .timer)
                    } else {
                        NavigationLink {
                            ExerciseDetailsView(for: exercise) { exercisesManager.update(exercise: $0) }
                                onDelete: { exercisesManager.delete(exercise: $0) }
                        } label: {
                            ExerciseDetailsShortView(for: exercise, displayDuration: exercise.type == .timer)
                        }
                    }
                }
            }
            .onDelete { exercisesManager.removeItems(at: $0) }
            .onMove { exercisesManager.moveItems(from: $0, to: $1) }
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
