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
                    .tint(.customAccentColor)
                    .onChange(of: viewModel.isTypeSet) { newValue in
                        withAnimation {
                            viewModel.onTypeSetChange(newValue: newValue)
                        }
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
                }
            
                HStack {
                    Text("Type")
                    Spacer()
                    ExerciseTypeView(type: viewModel.template.type)
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
                            ExerciseDurationView(type: viewModel.normalizedTemplate.type, duration: viewModel.normalizedTemplate.duration)
                                .foregroundColor(.secondary)
                        }
                    }
                    if viewModel.showReset {
                        Button("Reset") { viewModel.resetDuration() }
                            .disabled(viewModel.resetDurationDisabled)
                    }
                }
            } footer: {
                if let type = viewModel.template.type {
                    if type == .flow {
                        Text("Duration of a flow exercise is not limited")
                    } else if type == .tabata {
                        Text("Duration of a tabata exercise and its tasks is based on the general Settings of the application")
                    }
                }
            }
            
            if viewModel.showIntensity {
                Section {
                    intensityControl
                } footer: {
                    if viewModel.template.type == .tabata {
                        Text("Intensity of a tabata exercise can't be configured")
                    }
                }
            }
            
            if viewModel.showTasks {
                Section {
                    Button("View tasks") {
                        showTasks = true
                    }
                }
            }
            
        }
        .sheet(isPresented: $showTasks) {
            ExerciseEditorTasksView(exercise: viewModel.exercise)
        }
    }
    
    @ViewBuilder var intensityControl: some View {
        Picker("Intensity", selection: $viewModel.template.intensityType.animation()) {
            ForEach(Intensity.managedIntensities, id: \.self) { type in
                IntensityImage(type: type).tag(type as Intensity?)
            }
        }
        .pickerStyle(.segmented)
        
        HStack {
            Text("Intensity")
            Spacer()
            HStack {
                IntensityImage(type: viewModel.template.intensityType!)
                Text(viewModel.template.intensityType!.rawValue)
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
    
    @State static private var defaultTemplate = ExerciseTemplate.template
    @State static private var exampleTemplate = ExerciseTemplate.catCow
    
    static var previews: some View {
//        NavigationView {
//            ExerciseTemplateEditor(for: $defaultTemplate)
//        }
        
        NavigationView {
            ExerciseEditor(for: $exampleTemplate)
        }
    }
}
