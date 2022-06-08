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
                                ExerciseTemplateView(for: exercise) { viewModel.updateExerciseTemplate(template: $0)
                                }
                            } label: {
                                ExerciseDetailsShortView(for: exercise, displayDuration: true)
                            }
                        }
                    }
                    HStack {
                        // todo: selection control is here
                        // when plus is tapped, the exercise is added to the list and can be edited
                        Spacer()
                        Button() {
                            showNewExerciseView = true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                    
                    Button("Add new") {
                        showNewExerciseView = true
                    }
                }
            }
            .sheet(isPresented: $showNewExerciseView) {
                ExerciseTemplateView() { viewModel.addNewExerciseTemplate(template: $0) }
            }
            .navigationTitle(viewModel.isEditMode ? "Program template" : "New template")
            .toolbar {
                ToolbarItemGroup {
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
