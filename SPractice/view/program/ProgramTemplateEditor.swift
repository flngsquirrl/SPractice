//
//  ProgramTemplateEditor.swift
//  SPractice
//
//  Created by Yuliya Charniak on 20.06.22.
//

import SwiftUI

struct ProgramTemplateEditor: View {
    
    @ObservedObject var viewModel: ViewModel
    
    @State private var showNewExerciseView = false
    @State private var showExerciseSelectionView = false
    
    @State private var selectedExercise: ExerciseTemplate? = nil
    @Binding private var editMode: EditMode
    
    init(for template: Binding<ProgramTemplate>, editMode: Binding<EditMode>) {
        self.viewModel = ViewModel(for: template)
        self._editMode = editMode
    }
    
    var body: some View {
        Form {
            TextField("Program name", text: $viewModel.template.name)
            
            Section {
                Toggle("Rest intervals", isOn: $viewModel.template.useRest)
            } footer: {
                Text("Having rest between execises lets you take a deep breath and prepare for the upcoming exercise")
            }
            
            Section() {
                ForEach(viewModel.template.exercises) { exercise in
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
                .onMove{ viewModel.moveItems(from: $0, to: $1) }
                
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
                    Text("Exercises (\(viewModel.template.exercises.count))")
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
        .environment(\.editMode, $editMode)
        .sheet(item: $selectedExercise) { exercise in
            NavigationView {
                EditExerciseTemplateView(for: exercise) { viewModel.updateExerciseTemplate(exercise: $0) }
                }
                .accentColor(.customAccentColor)
        }
        .sheet(isPresented: $showExerciseSelectionView) {
            ExerciseTemplateSelectionView() { viewModel.addNewExerciseTemplates(exercises: $0) }
        }
        .sheet(isPresented: $showNewExerciseView) {
            NavigationView {
                AddExerciseTemplateView() { viewModel.addNewExerciseTemplate(exercise: $0) }
            }
            .accentColor(.customAccentColor)
        }
    }
}

struct ProgramTemplateEditor_Previews: PreviewProvider {
    @State static private var editMode: EditMode = .inactive
    
    @State static private var defaultTemplate = ProgramTemplate.defaultTemplate
    @State static private var exampleTemplate = ProgramTemplate.personal
    
    static var previews: some View {
        NavigationView {
            ProgramTemplateEditor(for: $defaultTemplate, editMode: $editMode)
        }
        
        NavigationView {
            ProgramTemplateEditor(for: $exampleTemplate, editMode: $editMode)
        }
    }
}
