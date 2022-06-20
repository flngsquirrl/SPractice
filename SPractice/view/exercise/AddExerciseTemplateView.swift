//
//  AddExerciseTemplateView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 10.06.22.
//

import SwiftUI

struct AddExerciseTemplateView: View {
    
    @Environment(\.dismiss) var dismiss
    var onAdd: (ExerciseTemplate) -> Void
    
    @State private var newTemplate = ExerciseTemplate.defaultTemplate
    
    init(onAdd: @escaping (ExerciseTemplate) -> Void) {
        self.onAdd = onAdd
    }
    
    var body: some View {
        ExerciseTemplateEditor(for: $newTemplate)
            .navigationTitle("New template")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        onAdd(newTemplate)
                        dismiss()
                    }
                }
                
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
    }
}

struct AddExerciseTemplateView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddExerciseTemplateView() { _ in }
        }
    }
}
