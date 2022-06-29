//
//  EditExerciseView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 10.06.22.
//

import SwiftUI

struct EditExerciseView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var exercise: ExerciseTemplate
    
    var onSave: (ExerciseTemplate) -> Void
    
    init(for template: ExerciseTemplate, onSave: @escaping (ExerciseTemplate) -> Void) {
        self._exercise = State<ExerciseTemplate>(initialValue: template)
        self.onSave = onSave
    }
    
    var body: some View {
        ExerciseEditor(for: $exercise)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        onSave(exercise.makeCopy())
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .navigationTitle("Exercise")
    }
}

struct EditExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EditExerciseView(for: ExerciseTemplate.catCow) { _ in }
        }
    }
}
