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
                        ForEach(ExerciseType.allCases, id: \.self) { type in
                            ExerciseTypeImage(type: type)
                                .tag(type as ExerciseType?)
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
                            IntensityTypeImage(type: viewModel.template.intensityType)
                            Text(viewModel.template.intensityType.rawValue)
                        }
                        .foregroundColor(.gray)
                        
                    }
                    Picker("Intensity", selection: $viewModel.template.intensityType.animation()) {
                        ForEach(IntensityType.allCases, id: \.self) { type in
                            IntensityTypeImage(type: type).tag(type as IntensityType?)
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

struct ExerciseEditor_Previews: PreviewProvider {
    
    @State static private var defaultTemplate = Exercise.defaultTemplate
    @State static private var exampleTemplate = Exercise.catCowNoType
    
    static var previews: some View {
//        NavigationView {
//            ExerciseTemplateEditor(for: $defaultTemplate)
//        }
        
        NavigationView {
            ExerciseEditor(for: $exampleTemplate)
        }
    }
}
