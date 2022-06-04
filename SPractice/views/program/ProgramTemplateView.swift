//
//  ProgramTemplateView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 4.05.22.
//

import SwiftUI

struct ProgramTemplateView: View {
    
    @ObservedObject var viewModel = ViewModel()
    @State private var showNewExerciseView = false
    
    var onSave: (ProgramTemplate) -> Void
    
    @Environment(\.dismiss) var dismiss
    
    init(onSave: @escaping (ProgramTemplate) -> Void) {
        self.onSave = onSave
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Program name", text: $viewModel.name)
                
                Section {
                    Toggle("Rest intervals", isOn: $viewModel.addRest)
                } footer: {
                    Text("Having rest between execises lets you take a deep breath and prepare for the upcoming exercise properly")
                }
                
                Section("Exercises") {
                    List {
                        ForEach(viewModel.exercises) { exercise in
                            NavigationLink() {
                                ExerciseTemplateView(template: exercise) { viewModel.updateExerciseTemplate(template: $0)
                                }
                            } label: {
                                Image(systemName: exercise.type.imageName)
                                Text(exercise.name)
                                Spacer()
                                Text(exercise.wrappedDuration)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    NavigationLink() {
                        ExerciseTemplateView() { viewModel.addNewExerciseTemplate(template: $0) }
                    } label: {
                        Text("Add new")
                            .foregroundColor(.lightOrange)
                    }
                }
            }
            .navigationTitle("New program")
            .navigationBarTitleDisplayMode(.inline)
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
