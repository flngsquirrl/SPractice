//
//  ExerciseEditor.swift
//  SPractice
//
//  Created by Yuliya Charniak on 18.06.22.
//

import SwiftUI

struct ExerciseEditor: View {

    @ObservedObject private var viewModel: ViewModel

    @State private var showSettings: Bool = false

    @FocusState private var fieldInFocus: FocusableField?
    var mode: EditorMode
    var navigatedFromProgram: Bool

    init(for template: Binding<EditorTemplate>, mode: EditorMode, navigatedFromProgram: Bool = false) {
        self.viewModel = ViewModel(for: template)
        self.mode = mode
        self.navigatedFromProgram = navigatedFromProgram
    }

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $viewModel.template.name)
                    .disableAutocorrection(true)
                    .focused($fieldInFocus, equals: .name)
                    .task {
                        if mode == .add {
                            await setInitialFocus()
                        }
                    }

                TextField("Description", text: $viewModel.template.description, axis: .vertical)
                    .disableAutocorrection(true)
                    .lineLimit(2...4)
                    .focused($fieldInFocus, equals: .description)
            }

            Section {
                Toggle("Set type", isOn: $viewModel.isTypeSet.animation())
                    .decorated()
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
                    InfoButton(for: .execiseType)
                    Spacer()
                    ExerciseTypeView(type: viewModel.template.type, mode: .textAndIcon)
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
                            ExerciseDurationView(for: viewModel.exercise)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                if viewModel.showTasks {
                    ExerciseTasksView(for: viewModel.exercise)
                }
            } footer: {
                if viewModel.showDurationFooter {
                    HStack {
                        if viewModel.template.type! == .flow {
                            Text("Duration of a flow exercise is not limited")
                        } else {
                            SettingsLink(text: "Sequence and duration of the tasks are based on", showSettings: $showSettings)
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

            if navigatedFromProgram {
                Toggle("Save as template", isOn: $viewModel.template.saveAsTemplate)
                    .decorated()
            }
        }
        .onSubmit {
            toggleFocus()
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                HideKeyboardButton()
            }
        }
        .sheet(isPresented: $showSettings) {
            SettingsSubgroupView(subgroup: .tabata)
        }
    }

    func toggleFocus() {
        fieldInFocus = FocusableField.moveFocusFrom(field: fieldInFocus)
    }

    private func setInitialFocus() async {
        try? await _Concurrency.Task.sleep(seconds: 0.75)
        fieldInFocus = .name
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
            InfoButton(for: .exerciseIntensity)
            Spacer()
            HStack {
                IntensityView(intensity: viewModel.template.intensity!, mode: .textAndIcon)
            }
            .foregroundColor(.secondary)
        }
    }

    var timerDurationControl: some View {
        DurationControl(minutes: $viewModel.minutes, seconds: $viewModel.seconds,
                        onMinutesChange: {viewModel.onMinutesChange(newValue: $0)},
                        onSecondsChange: {viewModel.onSecondsChange(newValue: $0)},
                        content: { durationControlContent })
    }

    @ViewBuilder var durationControlContent: some View {
        Text("Duration")
        InfoButton(for: .exerciseDuration)
        Spacer()
    }
}

struct ExerciseEditor_Previews: PreviewProvider {

    @State static private var defaultTemplate = ExerciseTemplate.template
    @State static private var exampleTemplate = ExerciseEditor.EditorTemplate(from: ExerciseTemplate.vasisthasana)

    static var previews: some View {
        //        NavigationStack {
        //            ExerciseTemplateEditor(for: $defaultTemplate)
        //        }

        NavigationStack {
            ExerciseEditor(for: $exampleTemplate, mode: .edit)
                .environmentObject(SettingsManager())
                .environmentObject(InfoController())
        }
    }
}
