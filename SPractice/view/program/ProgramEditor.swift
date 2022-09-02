//
//  ProgramEditor.swift
//  SPractice
//
//  Created by Yuliya Charniak on 20.06.22.
//

import SwiftUI

struct ProgramEditor: View {

    @ObservedObject var viewModel: ViewModel

    @State private var showNewExerciseView = false
    @State private var showExerciseSelectionView = false

    @State private var selectedExercise: ExerciseTemplate?
    @Binding private var editMode: EditMode

    @FocusState private var fieldInFocus: FocusableField?

    private var mode: EditorMode

    init(for template: Binding<ProgramTemplate>, mode: EditorMode, editMode: Binding<EditMode>) {
        self.viewModel = ViewModel(for: template)
        self.mode = mode
        self._editMode = editMode
    }

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $viewModel.template.name)
                    .disableAutocorrection(true)
                    .focused($fieldInFocus, equals: .name)
                    .onAppear {
                        if mode == .add {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                                fieldInFocus = .name
                            }
                        }
                    }
                TextField("Description", text: $viewModel.template.description, axis: .vertical)
                    .disableAutocorrection(true)
                    .lineLimit(2...4)
                    .focused($fieldInFocus, equals: .description)
            }

            ProgramDurationSection(program: viewModel.template)

            Section {
                Button {
                    hideKeyboard()
                    showNewExerciseView = true
                } label: {
                    Label("Add new", systemImage: "plus")
                }
                .disabled(editMode.isEditing)

                Button {
                    hideKeyboard()
                    showExerciseSelectionView = true
                } label: {
                    Label("Add from templates", systemImage: "plus")
                }
                .disabled(editMode.isEditing)

                ForEach(viewModel.template.exercises) { exercise in
                    HStack {
                        if !editMode.isEditing {
                            Button {
                                selectedExercise = exercise
                            } label: {
                                Image(systemName: "pencil.circle")
                            }
                        }
                        let isExerciseValid = ValidationService.isValidToPractice(exercise)
                        ExerciseShortView(for: exercise) {
                            ExerciseIcon(for: exercise.exerciseType, isIconAccented: !isExerciseValid, accentColor: .red)
                        }
                    }
                }
                .onDelete { viewModel.removeItems(at: $0) }
                .onMove { viewModel.moveItems(from: $0, to: $1) }
            } header: {
                HStack {
                    Text("Exercises (\(viewModel.template.exercises.count))")
                    Spacer()
                    if editMode.isEditing {
                        Button("Done") {
                            withAnimation {
                                editMode = .inactive
                            }
                        }
                    } else {
                        Button("Edit") {
                            hideKeyboard()
                            withAnimation {
                                editMode = .active
                            }
                        }
                        .disabled(!viewModel.template.hasExercises)
                    }
                }
                .font(.footnote)
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
        .environment(\.editMode, $editMode.animation())
        .sheet(item: $selectedExercise) { exercise in
            NavigationView {
                EditExerciseView(for: exercise) { viewModel.updateExercise(exercise: $0) }
            }
            .accentColor(.customAccentColor)
        }
        .sheet(isPresented: $showExerciseSelectionView) {
            ExerciseSelectionView { viewModel.addNewExercises(exercises: $0) }
        }
        .sheet(isPresented: $showNewExerciseView) {
            AddExerciseView(navigatedFromProgram: true) { viewModel.addNewExercise(exercise: $0) }
        }
    }

    func toggleFocus() {
        fieldInFocus = FocusableField.moveFocusFrom(field: fieldInFocus)
    }
}

struct ProgramEditor_Previews: PreviewProvider {
    @State static private var editMode: EditMode = .inactive

    @State static private var defaultTemplate = ProgramTemplate.template
    @State static private var exampleTemplate = ProgramTemplate.simpleYoga

    static var previews: some View {
        NavigationView {
            ProgramEditor(for: $defaultTemplate, mode: .add, editMode: $editMode)
        }

        NavigationView {
            ProgramEditor(for: $exampleTemplate, mode: .edit, editMode: $editMode)
        }
    }
}
