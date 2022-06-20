//
//  EditExerciseTemplateView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 10.06.22.
//

import SwiftUI

struct EditExerciseTemplateView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var template: ExerciseTemplate
    
    var onSave: (ExerciseTemplate) -> Void
    
    init(for template: ExerciseTemplate, onSave: @escaping (ExerciseTemplate) -> Void) {
        self._template = State<ExerciseTemplate>(initialValue: template)
        self.onSave = onSave
    }
    
    var body: some View {
        ExerciseTemplateEditor(for: $template)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        onSave(template)
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

struct EditExerciseTemplateView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EditExerciseTemplateView(for: ExerciseTemplate.catCow) { _ in }
        }
    }
}
