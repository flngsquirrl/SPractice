//
//  ExerciseEditor.swift
//  SPractice
//
//  Created by Yuliya Charniak on 18.06.22.
//

import SwiftUI

struct ExerciseEditor: View {
    
    @ObservedObject private var viewModel: ViewModel
    
    @State private var showTasks = false
    
    init(for template: Binding<Exercise>) {
        self.viewModel = ViewModel(for: template)
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Exercise name", text: $viewModel.exercise.name)
            }
            
            Section {
                Toggle("Set type", isOn: $viewModel.isTypeSet.animation())
                    .tint(.customAccentColor)
                    .onChange(of: viewModel.isTypeSet) { newValue in
                        withAnimation {
                            viewModel.onTypeSetChange(newValue: newValue)
                        }
                    }
                
                if viewModel.isTypeDefined {
                    Picker("Type", selection: $viewModel.exercise.type.animation()) {
                        ForEach(ExerciseType.allCases, id: \.self) { type in
                            ExerciseTypeImage(type: type)
                                .tag(type as ExerciseType?)
                        }
                    }
                    .onChange(of: viewModel.exercise.type) { viewModel.onTypeChange(newValue: $0) }
                    .pickerStyle(.segmented)
                }
            
                HStack {
                    Text("Type")
                    Spacer()
                    ExerciseTypeView(type: viewModel.exercise.type)
                        .foregroundColor(.secondary)
                }
            }
            
            Section {
                if viewModel.isTypeDefined {
                    HStack {
                        Text("Duration")
                        Spacer()
                        if viewModel.isTimer {
                            timerDurationControl
                        } else {
                            ExerciseDurationView(type: viewModel.exercise.type)
                                .foregroundColor(.secondary)
                        }
                    }
                    Button("Reset") { viewModel.resetDuration() }
                        .disabled(viewModel.resetDurationDisabled)
                }
            } footer: {
                if let type = viewModel.exercise.type {
                    if type == .flow {
                        Text("Duration of a flow exercise can't be defined")
                    } else if type == .tabata {
                        Text("Duration of a tabata exercise and its tasks is based on the current Settings")
                        }
                }
            }
            
            if viewModel.isTypeDefined {
                Section {
                    intensityControl
                }
                
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
                        TaskDetailsShortView(task: task, exerciseType: viewModel.exercise.type!)
                    }
                } header: {
                    Text("Tasks")
                } footer: {
                    switch viewModel.exercise.type! {
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
    
    @ViewBuilder var intensityControl: some View {
        Picker("Intensity", selection: $viewModel.exercise.intensityType.animation()) {
            ForEach(IntensityType.allCases, id: \.self) { type in
                IntensityTypeImage(type: type).tag(type as IntensityType?)
            }
        }
        .pickerStyle(.segmented)
        .disabled(viewModel.intensityDisabled)
        
        HStack {
            Text("Intensity")
            Spacer()
            HStack {
                IntensityTypeImage(type: viewModel.exercise.intensityType)
                Text(viewModel.exercise.intensityType.rawValue)
            }
            .foregroundColor(.secondary)
        }
    }
    
    @ViewBuilder var timerDurationControl: some View {
        Picker("Duration minutes", selection: $viewModel.minutes) {
            ForEach(0..<61) {
                Text(String(format: "%02d", $0))
            }
        }
        .onChange(of: viewModel.minutes) { viewModel.onMinutesChange(newValue: $0)}
        .labelsHidden()
        .pickerStyle(.menu)
        
        Text("\(Self.minutesUnit)")
            .foregroundColor(.secondary)
        
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
            .foregroundColor(.secondary)
    }
}

struct ExerciseEditor_Previews: PreviewProvider {
    
    @State static private var defaultTemplate = Exercise.defaultTemplate
    @State static private var exampleTemplate = Exercise.catCow
    
    static var previews: some View {
//        NavigationView {
//            ExerciseTemplateEditor(for: $defaultTemplate)
//        }
        
        NavigationView {
            ExerciseEditor(for: $exampleTemplate)
        }
    }
}
