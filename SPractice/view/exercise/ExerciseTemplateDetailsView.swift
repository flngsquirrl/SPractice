//
//  ExerciseTemplateDetailsView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 18.06.22.
//

import SwiftUI

struct ExerciseTemplateDetailsView: View {
    
    var template: ExerciseTemplate
    var onChange: (ExerciseTemplate) -> Void
    var onDelete: (ExerciseTemplate) -> Void
    
    @State private var showEditView = false
    
    var body: some View {
        List {
            HStack {
                Text("Type")
                Spacer()
                
                ExerciseTypeImage(type: template.type)
                Text(template.type?.rawValue ?? "not set")
            }
            
            if template.isTimer {
                HStack {
                    Text("Duration")
                    Spacer()
                    Text(ClockTime.getPaddedPresentation(for: template.duration!))
                }
            }
        }
        .navigationTitle(template.name)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    onDelete(template)
                } label: {
                    Image(systemName: "trash")
                }
                
                Button("Edit") {
                    showEditView = true
                }
            }
        }
        .sheet(isPresented: $showEditView) {
            NavigationView {
                EditExerciseTemplateView(for: template, onSave: onChange)
                }
                .accentColor(.customAccentColor)
        }
    }
}

struct ExerciseDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ExerciseTemplateDetailsView(template: ExerciseTemplate.catCow, onChange: { _ in }, onDelete: { _ in })
        }
    }
}
