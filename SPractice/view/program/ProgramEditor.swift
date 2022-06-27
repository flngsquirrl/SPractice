//
//  ProgramEditor.swift
//  SPractice
//
//  Created by Yuliya Charniak on 20.06.22.
//

import SwiftUI

struct ProgramEditor: View {
    
    @ObservedObject var viewModel: ViewModel
    
    @State private var showNewExerciseView = false
    @State private var showExerciseSelectionView = false
    
    @State private var selectedExercise: Exercise? = nil
    @Binding private var editMode: EditMode
    
    init(for template: Binding<Program>, editMode: Binding<EditMode>) {
        self.viewModel = ViewModel(for: template)
        self._editMode = editMode
    }
    
    var body: some View {
        Form {
            TextField("Program name", text: $viewModel.template.name)
            
            Section() {
                Button() {
                    showNewExerciseView = true
                } label: {
                    Label("Add new", systemImage: "plus")
                }
                .disabled(editMode.isEditing)
                Button() {
                    showExerciseSelectionView = true
                } label: {
                    Label("Add from existing", systemImage: "plus")
                }
                .disabled(editMode.isEditing)
                
                ForEach(viewModel.template.exercises) { exercise in
                    HStack {
                        if !editMode.isEditing {
                            Button() {
                                selectedExercise = exercise
                            } label: {
                                Image(systemName: "pencil.circle.fill")
                            }
                        }
                        ExerciseShortView(for: exercise, displayDuration: true)
                            .foregroundColor(.primary)
                    }
                }
                .onDelete { viewModel.removeItems(at: $0) }
                .onMove{ viewModel.moveItems(from: $0, to: $1) }
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
                        .disabled(!viewModel.template.hasExercises)
                    }
                }
            }
        }
        .environment(\.editMode, $editMode)
        .sheet(item: $selectedExercise) { exercise in
            NavigationView {
                EditExerciseView(for: exercise) { viewModel.updateExerciseTemplate(exercise: $0) }
                }
                .accentColor(.customAccentColor)
        }
        .sheet(isPresented: $showExerciseSelectionView) {
            ExerciseSelectionView() { viewModel.addNewExerciseTemplates(exercises: $0) }
        }
        .sheet(isPresented: $showNewExerciseView) {
            NavigationView {
                AddExerciseView() { viewModel.addNewExerciseTemplate(exercise: $0) }
            }
            .accentColor(.customAccentColor)
        }
    }
}

struct ProgramEditor_Previews: PreviewProvider {
    @State static private var editMode: EditMode = .inactive
    
    @State static private var defaultTemplate = Program.defaultTemplate
    @State static private var exampleTemplate = Program.personal
    
    static var previews: some View {
        NavigationView {
            ProgramEditor(for: $defaultTemplate, editMode: $editMode)
        }
        
        NavigationView {
            ProgramEditor(for: $exampleTemplate, editMode: $editMode)
        }
    }
}
