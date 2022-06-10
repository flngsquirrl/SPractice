//
//  ProgramTemplateView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 4.05.22.
//

import SwiftUI

struct ProgramTemplateView: View {
    
    @ObservedObject var viewModel: ViewModel
    @State private var showNewExerciseView = false
    @State private var showExerciseSelectionView = false
    
    var onSave: (ProgramTemplate) -> Void
    
    @Environment(\.dismiss) var dismiss
    
    init(onSave: @escaping (ProgramTemplate) -> Void) {
        self.onSave = onSave
        self.viewModel = ViewModel()
    }
    
    init(for template: ProgramTemplate, onSave: @escaping (ProgramTemplate) -> Void) {
        self.init(onSave: onSave)
        self.viewModel = ViewModel(for: template)
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Program name", text: $viewModel.name)
                
                Section {
                    Toggle("Rest intervals", isOn: $viewModel.addRest)
                } footer: {
                    Text("Having rest between execises lets you take a deep breath and prepare for the upcoming exercise")
                }
                
                Section("Exercises") {
                    List {
                        ForEach(viewModel.exercises) { exercise in
                            NavigationLink() {
                                EditExerciseTemplateView(template: exercise) { viewModel.updateExerciseTemplate(template: $0) }
                            } label: {
                                ExerciseDetailsShortView(for: exercise, displayDuration: true)
                            }
                        }
                    }
                    HStack {
                        Button() {
                            showExerciseSelectionView = true
                        } label: {
                            Label("Select from templates", systemImage: "plus")
                        }
                    }
                    
                    Button() {
                        showNewExerciseView = true
                    } label: {
                        Label("Add new", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showExerciseSelectionView) {
                ExerciseTemplateSelectionView() { viewModel.addNewExerciseTemplates(templates: $0) }
            }
            .sheet(isPresented: $showNewExerciseView) {
                AddExerciseTemplateView() { viewModel.addNewExerciseTemplate(template: $0) }
            }
            .navigationTitle(viewModel.isEditMode ? "Program template" : "New template")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let template = viewModel.prepareNewProgramTemplate()
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
        }
        .accentColor(.customAccentColor)
    }
}

struct NewProgramView_Previews: PreviewProvider {
    static var previews: some View {
        ProgramTemplateView() { _ in }
    }
}
