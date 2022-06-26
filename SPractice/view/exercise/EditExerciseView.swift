//
//  EditExerciseView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 10.06.22.
//

import SwiftUI

struct EditExerciseView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var template: Exercise
    
    var onSave: (Exercise) -> Void
    
    init(for template: Exercise, onSave: @escaping (Exercise) -> Void) {
        self._template = State<Exercise>(initialValue: template)
        self.onSave = onSave
    }
    
    var body: some View {
        ExerciseEditor(for: $template)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        onSave(template.makeCopy())
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .navigationTitle("Exercise template")
    }
}

struct EditExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EditExerciseView(for: Exercise.catCow) { _ in }
        }
    }
}
