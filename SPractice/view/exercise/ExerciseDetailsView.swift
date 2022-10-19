//
//  ExerciseDetailsView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 18.06.22.
//

import SwiftUI

struct ExerciseDetailsView: View, UpdateProcessor, DeleteProcessor {

    private var exercise: ExerciseTemplate
    var onUpdate: ((ExerciseTemplate) -> Void)?
    var onDelete: ((ExerciseTemplate) -> Void)?

    @State private var showEditView = false

    init(for exercise: ExerciseTemplate) {
        self.exercise = exercise
    }

    var body: some View {
        ExerciseContentsView(exercise: exercise)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    DeleteToolbarButton(item: exercise) {
                        onDelete?($0)
                    }

                    Button("Edit") {
                        showEditView = true
                    }
                }
            }
            .sheet(isPresented: $showEditView) {
                NavigationStack {
                    EditExerciseView(for: exercise, onSave: onUpdate ?? { _ in })
                }
                .accentColor(.customAccentColor)
            }
    }
}

struct ExerciseDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ExerciseDetailsView(for: .catCow)
        }

        NavigationStack {
            ExerciseDetailsView(for: .vasisthasana)
        }

        NavigationStack {
            ExerciseDetailsView(for: .surjaNamascarA)
        }
    }
}
