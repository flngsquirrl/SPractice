//
//  ExerciseDetailsView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 18.06.22.
//

import SwiftUI

struct ExerciseDetailsView: View {
    
    @ObservedObject private var viewModel: ViewModel
    
    private var onChange: (ExerciseTemplate) -> Void
    private var onDelete: (ExerciseTemplate) -> Void
    
    @State private var showEditView = false
    
    init(for exercise: ExerciseTemplate, onChange: @escaping (ExerciseTemplate) -> Void, onDelete: @escaping (ExerciseTemplate) -> Void) {
        self.viewModel = ViewModel(for: exercise)
        self.onChange = onChange
        self.onDelete = onDelete
    }
    
    var body: some View {
        List {
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
                Section("Tasks") {
                    ForEach(viewModel.tasks) { task in
                        TaskDetailsShortView(task: task, exerciseType: viewModel.exercise.type!)
                    }
                }
            }
        }
        .navigationTitle(viewModel.exercise.name)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    onDelete(viewModel.exercise)
                } label: {
                    Image(systemName: "trash")
                }
                
                Button("Edit") {
                    showEditView = true
                }
            }
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
            ExerciseDetailsView(for: ExerciseTemplate.surjaNamascar, onChange: { _ in }, onDelete: { _ in })
        }
    }
}
