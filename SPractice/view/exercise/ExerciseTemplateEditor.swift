//
//  ExerciseTemplateEditor.swift
//  SPractice
//
//  Created by Yuliya Charniak on 18.06.22.
//

import SwiftUI

struct ExerciseTemplateEditor: View {
    
    @ObservedObject private var viewModel: ViewModel
    
    init(for template: Binding<ExerciseTemplate>) {
        self.viewModel = ViewModel(for: template)
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Exercise name", text: $viewModel.template.name)
            }
            
            Section {
                Toggle("Type", isOn: $viewModel.isTypeSet)
                    .onChange(of: viewModel.isTypeSet) {
                        viewModel.onTypeSetChange(newValue: $0)
                    }
                
                Group {
                    Picker("Exercise type", selection: $viewModel.template.type) {
                        ForEach(Exercise.ExerciseType.allCases, id: \.self) { type in
                            Text(type.rawValue).tag(type as Exercise.ExerciseType?)
                        }
                    }
                    .disabled(!viewModel.isTypeSet)
                    .pickerStyle(.segmented)
                
                    if viewModel.isTimer {
                        HStack {
                            Picker("Duration minutes", selection: $viewModel.minutes) {
                                ForEach(0..<61) {
                                    Text(String(format: "%02d", $0))
                                }
                            }
                            .onChange(of: viewModel.minutes) { viewModel.onMinutesChange(newValue: $0)}
                            .labelsHidden()
                            .pickerStyle(.menu)
                            
                            Text("\(Self.minutesUnit)")
                            
                            Picker("Duration seconds", selection: $viewModel.seconds) {
                                ForEach(ViewModel.secondsSelectionArray, id: \.self) {
                                    Text(String(format: "%02d", $0))
                                }
                            }
                            .onChange(of: viewModel.seconds) { viewModel.onSecondsChange(newValue: $0)}
                            .disabled(!viewModel.areSecondsEnabled)
                            .labelsHidden()
                            .pickerStyle(.menu)
                            
                            Text("\(Self.secondsUnit)")
                            
                            Spacer()
                            
                            Button("Reset") { viewModel.resetDuration() }
                                .foregroundColor(.lightOrange)
                                .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                .disabled(!viewModel.isTypeSet)
            }
        }
    }
}

struct ExerciseTemplateEditor_Previews: PreviewProvider {
    
    @State static private var defaultTemplate = ExerciseTemplate.defaultTemplate
    @State static private var exampleTemplate = ExerciseTemplate.surjaNamascar
    
    static var previews: some View {
        NavigationView {
            ExerciseTemplateEditor(for: $defaultTemplate)
        }
        
        NavigationView {
            ExerciseTemplateEditor(for: $exampleTemplate)
        }
    }
}
