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
                Toggle("Set type", isOn: $viewModel.isTypeSet.animation())
                    .onChange(of: viewModel.isTypeSet) {
                        viewModel.onTypeSetChange(newValue: $0)
                    }
                
            }
            
            if viewModel.isTypeSet {
                Section {
                    HStack {
                        Text("Type")
                        Spacer()
                        HStack {
                            ExerciseTypeImage(type: viewModel.template.type)
                            Text(viewModel.template.type?.rawValue ?? "")
                        }
                        .foregroundColor(.gray)
                    }
                        
                    Picker("Type", selection: $viewModel.template.type.animation()) {
                        ForEach(Exercise.ExerciseType.allCases, id: \.self) { type in
                            ExerciseTypeImage(type: type)
                                .tag(type as Exercise.ExerciseType?)
                        }
                    }
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
                                .buttonStyle(.plain)
                                .foregroundColor(.customAccentColor)
                        }
                    }
                }
                
                Section {
                    if viewModel.template.type != .tabata {
                        HStack {
                            Text("Intensity")
                            Spacer()
                            HStack {
                                TaskTypeImage(type: viewModel.template.taskType!)
                                Text(viewModel.template.taskType!.rawValue)
                            }
                            .foregroundColor(.gray)
                        }
                        Picker("Intensity", selection: $viewModel.template.taskType.animation()) {
                            ForEach(Task.TaskType.allCases, id: \.self) { type in
                                TaskTypeImage(type: type).tag(type as Task.TaskType?)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                }
            }
        }
    }
}

struct ExerciseTemplateEditor_Previews: PreviewProvider {
    
    @State static private var defaultTemplate = ExerciseTemplate.defaultTemplate
    @State static private var exampleTemplate = ExerciseTemplate.catCow
    
    static var previews: some View {
//        NavigationView {
//            ExerciseTemplateEditor(for: $defaultTemplate)
//        }
        
        NavigationView {
            ExerciseTemplateEditor(for: $exampleTemplate)
        }
    }
}
