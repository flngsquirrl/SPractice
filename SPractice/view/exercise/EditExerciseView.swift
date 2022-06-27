//
//  EditExerciseView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 10.06.22.
//

import SwiftUI

struct EditExerciseView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var exercise: Exercise
    
    var onSave: (Exercise) -> Void
    
    init(for template: Exercise, onSave: @escaping (Exercise) -> Void) {
        self._exercise = State<Exercise>(initialValue: template)
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
            EditExerciseView(for: Exercise.catCow) { _ in }
        }
    }
}
