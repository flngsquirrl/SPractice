//
//  AddExerciseView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 10.06.22.
//

import SwiftUI

struct AddExerciseView: View {
    
    @Environment(\.dismiss) var dismiss
    var onAdd: (Exercise) -> Void
    
    @State private var newTemplate = Exercise.defaultTemplate
    
    init(onAdd: @escaping (Exercise) -> Void) {
        self.onAdd = onAdd
    }
    
    var body: some View {
        ExerciseEditor(for: $newTemplate)
            .navigationTitle("New template")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        
                        onAdd(Exercise(from: newTemplate))
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

struct AddExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddExerciseView() { _ in }
        }
    }
}
