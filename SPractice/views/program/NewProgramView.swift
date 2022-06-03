//
//  NewProgramView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 4.05.22.
//

import SwiftUI

struct NewProgramView: View {
    
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
                                // exercise details
                            } label: {
                                Image(systemName: exercise.type.imageName)
                                Text(exercise.name)
                                Spacer()
                                Text(exercise.wrappedDuration)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    Button() {
                        showNewExerciseView = true
                    } label: {
                        Text("Add new")
                    }
                }
                .sheet(isPresented: $showNewExerciseView) {
                    NewExerciseView() { viewModel.addNewExerciseTemplate(template: $0) }
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
        NewProgramView() { _ in }
    }
}
