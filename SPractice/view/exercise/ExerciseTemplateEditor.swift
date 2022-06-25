//
//  ExerciseTemplateEditor.swift
//  SPractice
//
//  Created by Yuliya Charniak on 18.06.22.
//

import SwiftUI

struct ExerciseTemplateEditor: View {
    
    @ObservedObject private var viewModel: ViewModel
    
    @State private var showTasks = false
    
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
                    .onChange(of: viewModel.isTypeSet) { newValue in
                        withAnimation {
                            viewModel.onTypeSetChange(newValue: newValue)
                        }
                    }
            
                HStack {
                    Text("Type")
                    Spacer()
                    ExerciseTypeView(type: viewModel.template.type)
                        .foregroundColor(.gray)
                }

                if viewModel.isTypeDefined {
                    Picker("Type", selection: $viewModel.template.type.animation()) {
                        ForEach(Exercise.ExerciseType.allCases, id: \.self) { type in
                            ExerciseTypeImage(type: type)
                                .tag(type as Exercise.ExerciseType?)
                        }
                    }
                    .onChange(of: viewModel.template.type) { viewModel.onTypeChange(newValue: $0) }
                    .pickerStyle(.segmented)
                    
                    if viewModel.showDuration {
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
                            .disabled(viewModel.areSecondsDisabled)
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
            }
                
            if viewModel.showIntensity {
                Section {
                    HStack {
                        Text("Intensity")
                        Spacer()
                        HStack {
                            TaskTypeImage(type: viewModel.template.taskType)
                            Text(viewModel.template.taskType.rawValue)
                        }
                        .foregroundColor(.gray)
                        
                    }
                    Picker("Intensity", selection: $viewModel.template.taskType.animation()) {
                        ForEach(Task.TaskType.allCases, id: \.self) { type in
                            TaskTypeImage(type: type).tag(type as Task.TaskType?)
                        }
                    }
                    .pickerStyle(.segmented)
                    .disabled(viewModel.intensityDisabled)
                }
            }
            
            if viewModel.isTypeDefined {
                Section {
                    Button("View tasks") {
                        showTasks = true
                    }
                }
            }
        }
        .sheet(isPresented: $showTasks) {
            List {
                Section {
                    ForEach(viewModel.tasks) { task in
                        TaskDetailsShortView(task: task, exerciseType: viewModel.template.type!)
                    }
                } header: {
                    Text("Tasks")
                } footer: {
                    switch viewModel.template.type! {
                    case .flow:
                        Text("Edit the template to change the intensity of the task")
                    case .timer:
                        Text("Edit the template to change intensity and duration of the task")
                    case .tabata:
                        Text("Tasks sequence and duration for a tabata exercise are based on the current Settings")

                    }
                }
            }
        }
    }
}

struct ExerciseTemplateEditor_Previews: PreviewProvider {
    
    @State static private var defaultTemplate = ExerciseTemplate.defaultTemplate
    @State static private var exampleTemplate = ExerciseTemplate.catCowNoType
    
    static var previews: some View {
//        NavigationView {
//            ExerciseTemplateEditor(for: $defaultTemplate)
//        }
        
        NavigationView {
            ExerciseTemplateEditor(for: $exampleTemplate)
        }
    }
}
