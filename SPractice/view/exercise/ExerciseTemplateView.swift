//
//  ExerciseTemplateView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 3.05.22.
//

import SwiftUI

struct ExerciseTemplateView: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var onSave: (ExerciseTemplate) -> Void
    
    @Environment(\.dismiss) var dismiss
    
    init(onSave: @escaping (ExerciseTemplate) -> Void) {
        self.onSave = onSave
        self.viewModel = ViewModel()
    }
    
    init(for template: ExerciseTemplate, onSave: @escaping (ExerciseTemplate) -> Void) {
        self.init(onSave: onSave)
        self.viewModel = ViewModel(for: template)
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Exercise name", text: $viewModel.name)
            }
            
            Section {
                Toggle("Type", isOn: $viewModel.isTypeSet)
                
                Group {
                    Picker("Exercise type", selection: $viewModel.type) {
                        ForEach(Exercise.ExerciseType.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .disabled(!viewModel.isTypeSet)
                    .pickerStyle(.segmented)
                
                    if (viewModel.type == .timer) {
                        HStack {
                            Picker("Duration minutes", selection: $viewModel.minutes) {
                                ForEach(0..<60) {
                                    Text("\($0)")
                                }
                            }
                            .labelsHidden()
                            .pickerStyle(.menu)
                            
                            Text("min")
                            Text(":")
                            
                            Picker("Duration seconds", selection: $viewModel.seconds) {
                                ForEach(ViewModel.secondsSelectionArray, id: \.self) {
                                    Text("\($0)")
                                }
                            }
                            .labelsHidden()
                            .pickerStyle(.menu)
                            
                            Text("sec")
                            
                            Spacer()
                            
                            Button("Reset") {}
                                .onTapGesture {
                                    viewModel.resetDuration()
                                }
                        }
                    }
                }
                .disabled(!viewModel.isTypeSet)
            }
        }
        .navigationTitle(viewModel.isEditMode ? "Exercise template" : "New template")
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                
                if viewModel.isEditMode {
                    Button {
                        // todo: process delete
                    } label: {
                        Image(systemName: "trash")
                    }
                }
                
                Button() {
                    let template = viewModel.prepareNewExerciseTemplate()
                    onSave(template)
                    
                    dismiss()
                } label: {
                    Text(viewModel.isEditMode ? "Save" : "Add")
                }
            }
            
            ToolbarItemGroup(placement: .navigationBarLeading) {
                if !viewModel.isEditMode {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct NewExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        
        NavigationView {
            ExerciseTemplateView() { _ in }
        }
        
        NavigationView {
            ExerciseTemplateView(for: ExerciseTemplate.surjaNamascar) { _ in }
        }

    }
}
