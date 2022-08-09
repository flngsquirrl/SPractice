//
//  ExerciseDetailsView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 18.06.22.
//

import SwiftUI

struct ExerciseDetailsView: DetailsView {
    
    @ObservedObject private var viewModel: ViewModel
    
    private var onChange: (ExerciseTemplate) -> Void
    private var onDelete: (ExerciseTemplate) -> Void
    
    @ObservedObject var exercises = Exercises.shared
    @Environment(\.horizontalSizeClass) var sizeClass
    
    @State private var showEditView = false
    @State private var showDeleteConfirmation = false
    
    init(for exercise: ExerciseTemplate, onChange: @escaping (ExerciseTemplate) -> Void, onDelete: @escaping (ExerciseTemplate) -> Void) {
        self.viewModel = ViewModel(for: exercise)
        self.onChange = onChange
        self.onDelete = onDelete
    }
    
    var isDeleted: Bool {
        !exercises.contains(viewModel.exercise)
    }
    
    var detailsContent: some View {
        List {
            Section {
                HStack(alignment: .top) {
                    if viewModel.exercise.isExample {
                        Image(systemName: "bookmark")
                            .foregroundColor(.secondary)
                    }
                    Text(viewModel.exercise.name)
                        .fontWeight(.semibold)
                }
                if viewModel.showDescription {
                    Text(viewModel.exercise.description)
                        .foregroundColor(.secondary)
                }
            } footer: {
                if viewModel.exercise.isExample {
                    HStack(spacing: 0) {
                        Text("This is an example ")
                        InfoButton()
                    }
                }
            }
            
            Section {
                HStack {
                    Text("Type")
                    InfoButton()
                    Spacer()
                    ExerciseTypeView(type: viewModel.exercise.type, mode: .iconAndText)
                        .foregroundColor(.secondary)
                }
                
                if viewModel.showDetails {
                    HStack {
                        Text("Duration")
                        InfoButton()
                        Spacer()
                        ExerciseDurationView(for: viewModel.exercise, isVerbose: true)
                            .foregroundColor(.secondary)
                    }
                
                    HStack {
                        Text("Intensity")
                        InfoButton()
                        Spacer()
                        IntensityView(intensity: viewModel.exercise.intensity, mode: .iconAndText)
                            .foregroundColor(.secondary)
                    }
                }
            }
            
            if viewModel.showTasks {
                Section {
                    ExerciseTasksButton(exercise: viewModel.exercise)
                } footer: {
                    SettingsLinkView(text: "Sequence and duration of the tasks are based on", settingsSubGroup: .tabata)
                }
            }
        }
        .navigationTitle("Exercise")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    showDeleteConfirmation = true
                } label: {
                    Image(systemName: "trash")
                }
                
                Button("Edit") {
                    showEditView = true
                }
            }
        }
        .alert(DeleteAlertConstants.title, isPresented: $showDeleteConfirmation) {
            DeleteAlertContent(item: viewModel.exercise) {
                onDelete($0)
            }
        } message: {
            DeleteAlertConstants.messageText
        }
        .sheet(isPresented: $showEditView) {
            NavigationView {
                EditExerciseView(for: viewModel.exercise, onSave: onChange)
            }
            .accentColor(.customAccentColor)
        }
    }
}

struct ExerciseDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ExerciseDetailsView(for: ExerciseTemplate.catCow, onChange: { _ in }, onDelete: { _ in })
        }
        
        NavigationView {
            ExerciseDetailsView(for: ExerciseTemplate.vasihsthasana, onChange: { _ in }, onDelete: { _ in })
        }
        
        NavigationView {
            ExerciseDetailsView(for: ExerciseTemplate.surjaNamascarA, onChange: { _ in }, onDelete: { _ in })
        }
    }
}
