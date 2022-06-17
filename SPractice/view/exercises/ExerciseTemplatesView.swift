//
//  ExerciseTemplatesView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 8.06.22.
//

import SwiftUI

struct ExerciseTemplatesView: View, EditableView {
    
    @Environment(\.editMode) var editMode
    
    @StateObject var viewModel = ViewModel()
    @State private var showAddNewView = false
    
    var body: some View {
        Group {
            ForEach(viewModel.templates) { template in
                if isEditMode {
                    ExerciseDetailsShortView(for: template, displayDuration: template.type == .timer)
                } else {
                    NavigationLink {
                        EditExerciseTemplateView(template: template) { viewModel.updateTemplate(template: $0) }
                    } label: {
                        ExerciseDetailsShortView(for: template, displayDuration: template.type == .timer)
                    }
                }
            }
            .onDelete { viewModel.removeItems(at: $0) }
            .onMove { viewModel.moveItems(from: $0, to: $1) }
            
            Section {
                Button() {
                    showAddNewView = true
                } label: {
                    Text("Add new")
                }
                .disabled(isEditMode)
            }
        }
        .sheet(isPresented: $showAddNewView) {
            AddExerciseTemplateView() { viewModel.addNewTemplate(template: $0) }
        }
    }
}

struct ExerciseTemplatesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                ExerciseTemplatesView()
            }
        }
    }
}
