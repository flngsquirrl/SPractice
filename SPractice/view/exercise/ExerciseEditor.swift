//
//  ExerciseEditor.swift
//  SPractice
//
//  Created by Yuliya Charniak on 18.06.22.
//

import SwiftUI

struct ExerciseEditor: View {
    
    @ObservedObject private var viewModel: ViewModel
    
    init(for template: Binding<EditorTemplate>) {
        self.viewModel = ViewModel(for: template)
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Exercise name", text: $viewModel.template.name)
                    .disableAutocorrection(true)
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
                    .pickerStyle(.segmented)
                }
            
                HStack {
                    Text("Type")
                    InfoButton()
                    Spacer()
                    ExerciseTypeView(type: viewModel.template.type, mode: .iconAndText)
                        .foregroundColor(.secondary)
                }
            }
            
            Section {
                if viewModel.isTypeDefined {
                    if viewModel.template.isTimer {
                        timerDurationControl
                    } else {
                        HStack {
                            durationControlContent
                            ExerciseDurationView(type: viewModel.exercise.type, duration: viewModel.exercise.duration)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                if viewModel.showTasks {
                    ExerciseTasksButton(exercise: viewModel.exercise)
                }
            } footer: {
                if viewModel.showDurationFooter {
                    HStack {
                        if viewModel.template.type! == .flow {
                            SettingsLinkView(text: "Duration of a flow exercise is not limited, but for practice can be configured in", settingsSubGroup: .flow)
                        } else {
                            SettingsLinkView(text: "Duration of a tabata exercise is based on the general", settingsSubGroup: .tabata)
                        }
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
        }
    }
    
    @ViewBuilder var intensityControl: some View {
        if viewModel.showIntensitySelection {
            Picker("Intensity", selection: $viewModel.template.intensity.animation()) {
                ForEach(Intensity.managedIntensities, id: \.self) { type in
                    IntensityImage(intensity: type).tag(type as Intensity?)
                }
            }
            .pickerStyle(.segmented)
        }
        
        HStack {
            Text("Intensity")
            InfoButton()
            Spacer()
            HStack {
                IntensityImage(intensity: viewModel.template.intensity!)
                Text(viewModel.template.intensity!.rawValue)
            }
            .foregroundColor(.secondary)
        }
    }
    
    var timerDurationControl: some View {
        DurationControl(minutes: $viewModel.minutes, seconds: $viewModel.seconds, onMinutesChange: {viewModel.onMinutesChange(newValue: $0)}, onSecondsChange: {viewModel.onSecondsChange(newValue: $0)}) {
            durationControlContent
        }
    }
    
    @ViewBuilder var durationControlContent: some View {
        Text("Duration")
        InfoButton()
        Spacer()
    }
}

struct ExerciseEditor_Previews: PreviewProvider {
    
    @State static private var defaultTemplate = ExerciseTemplate.template
    @State static private var exampleTemplate = ExerciseEditor.EditorTemplate(from: ExerciseTemplate.vasihsthasana)
    
    static var previews: some View {
//        NavigationView {
//            ExerciseTemplateEditor(for: $defaultTemplate)
//        }
        
        NavigationView {
            ExerciseEditor(for: $exampleTemplate)
        }
    }
}
