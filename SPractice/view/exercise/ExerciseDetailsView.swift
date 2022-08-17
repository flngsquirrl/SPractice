//
//  ExerciseDetailsView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 18.06.22.
//

import SwiftUI

struct ExerciseDetailsView: DetailsView {
    
    private var exercise: ExerciseTemplate
    
    private var onChange: (ExerciseTemplate) -> Void
    private var onDelete: (ExerciseTemplate) -> Void
    
    @ObservedObject var exercises = Exercises.shared
    @Environment(\.horizontalSizeClass) var sizeClass
    
    @State private var showEditView = false
    
    init(for exercise: ExerciseTemplate, onChange: @escaping (ExerciseTemplate) -> Void, onDelete: @escaping (ExerciseTemplate) -> Void) {
        self.exercise = exercise
        self.onChange = onChange
        self.onDelete = onDelete
    }
    
    var isDeleted: Bool {
        !exercises.contains(exercise)
    }
    
    var detailsContent: some View {
        ExerciseContentsView(exercise: exercise)
            .navigationTitle("Exercise")
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
                NavigationView {
                    EditExerciseView(for: exercise, onSave: onChange)
                }
                .accentColor(.customAccentColor)
            }
    }
}

struct ExerciseDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ExerciseDetailsView(for: ExerciseTemplate.catCow, onChange: { _ in }, onDelete: { _ in })
        }
        
        NavigationView {
            ExerciseDetailsView(for: ExerciseTemplate.vasihsthasana, onChange: { _ in }, onDelete: { _ in })
        }
        
        NavigationView {
            ExerciseDetailsView(for: ExerciseTemplate.surjaNamascarA, onChange: { _ in }, onDelete: { _ in })
        }
    }
}
