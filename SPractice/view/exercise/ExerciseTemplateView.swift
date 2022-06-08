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
        NavigationView {
            Form {
                Section {
                    TextField("Exercise name", text: $viewModel.name)
                }
                
                Section {
                    Toggle("Type", isOn: $viewModel.isTypeSet)
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
                            .disabled(!viewModel.isTypeSet)
                            .pickerStyle(.menu)
                            .frame(width: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            
                            Text("min")
                            Text(":")
                            
                            Picker("Duration seconds", selection: $viewModel.seconds) {
                                ForEach(0..<60) {
                                    Text("\($0)")
                                }
                            }
                            .labelsHidden()
                            .disabled(!viewModel.isTypeSet)
                            .pickerStyle(.menu)
                            .frame(width: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            
                            Text("sec")
                        }
                    }
                }
            }
            .navigationTitle(viewModel.isEditMode ? "Exercise template" : "New template")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button() {
                        let template = viewModel.prepareNewExerciseTemplate()
                        onSave(template)
                        
                        dismiss()
                    } label: {
                        Text(viewModel.isEditMode ? "Save" : "Add")
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

struct NewExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        
        ExerciseTemplateView() { _ in }
        
        ExerciseTemplateView(for: ExerciseTemplate.surjaNamascar) { _ in }

    }
}
