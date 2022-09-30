//
//  ExerciseDetailsView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 18.06.22.
//

import SwiftUI

struct ExerciseDetailsView: View {

    private var exercise: ExerciseTemplate
    private var onChange: (ExerciseTemplate) -> Void
    private var onDelete: (ExerciseTemplate) -> Void

    @State private var showEditView = false

    init(for exercise: ExerciseTemplate, onChange: @escaping (ExerciseTemplate) -> Void, onDelete: @escaping (ExerciseTemplate) -> Void) {
        self.exercise = exercise
        self.onChange = onChange
        self.onDelete = onDelete
    }

    var body: some View {
        ExerciseContentsView(exercise: exercise)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    DeleteToolbarButton(item: exercise) {
                        onDelete($0)
                    }

                    Button("Edit") {
                        showEditView = true
                    }
                }
            }
            .sheet(isPresented: $showEditView) {
                NavigationStack {
                    EditExerciseView(for: exercise, onSave: onChange)
                }
                .accentColor(.customAccentColor)
            }
    }
}

struct ExerciseDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ExerciseDetailsView(for: .catCow, onChange: { _ in }, onDelete: { _ in })
        }

        NavigationStack {
            ExerciseDetailsView(for: .vasisthasana, onChange: { _ in }, onDelete: { _ in })
        }

        NavigationStack {
            ExerciseDetailsView(for: .surjaNamascarA, onChange: { _ in }, onDelete: { _ in })
        }
    }
}
