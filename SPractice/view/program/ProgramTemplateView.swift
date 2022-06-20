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
    
    @State private var selectedExercise: ExerciseTemplate? = nil
    @State private var editMode: EditMode = .inactive
    
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
                
                Section() {
                    ForEach(viewModel.exercises) { exercise in
                        HStack {
                            if !editMode.isEditing {
                                Button() {
                                    selectedExercise = exercise
                                } label: {
                                    Image(systemName: "pencil.circle.fill")
                                }
                            }
                            
                            ExerciseDetailsShortView(for: exercise, displayDuration: true)
                                .foregroundColor(.primary)
                        }
                    }
                    .onDelete { viewModel.removeItems(at: $0) }
                    .onMove{ _,_  in }
                    
                    Button() {
                        showExerciseSelectionView = true
                    } label: {
                        Label("Select from templates", systemImage: "plus")
                    }
                    .disabled(editMode.isEditing)
                    
                    Button() {
                        showNewExerciseView = true
                    } label: {
                        Label("Add new", systemImage: "plus")
                    }
                    .disabled(editMode.isEditing)
                } header: {
                    HStack {
                        Text("Exercises (\(viewModel.exercises.count))")
                        Spacer()
                        if editMode.isEditing {
                            Button("Done") {
                                withAnimation {
                                    editMode = .inactive
                                }
                            }
                        } else {
                            Button("Edit") {
                                withAnimation {
                                    editMode = .active
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle(viewModel.isEditMode ? "Program template" : "New template")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let template = viewModel.prepareNewProgramTemplate()
                        onSave(template)
                        dismiss()
                    }
                    .disabled(editMode.isEditing)
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .environment(\.editMode, $editMode)
            .sheet(item: $selectedExercise) { exercise in
                NavigationView {
                    EditExerciseTemplateView(for: exercise) { viewModel.updateExerciseTemplate(template: $0) }
                    }
                    .accentColor(.customAccentColor)
            }
            .sheet(isPresented: $showExerciseSelectionView) {
                ExerciseTemplateSelectionView() { viewModel.addNewExerciseTemplates(templates: $0) }
            }
            .sheet(isPresented: $showNewExerciseView) {
                AddExerciseTemplateView() { viewModel.addNewExerciseTemplate(template: $0) }
            }
        }
        .accentColor(.customAccentColor)
    }
}

struct NewProgramView_Previews: PreviewProvider {
    static var previews: some View {
        ProgramTemplateView() { _ in }
        
        ProgramTemplateView(for: ProgramTemplate.personal) { _ in }
    }
}
