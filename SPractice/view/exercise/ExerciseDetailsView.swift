//
//  ExerciseDetailsView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 18.06.22.
//

import SwiftUI

struct ExerciseDetailsView: View {
    
    @ObservedObject private var viewModel: ViewModel
    
    private var onChange: (Exercise) -> Void
    private var onDelete: (Exercise) -> Void
    
    @State private var showEditView = false
    
    init(for exercise: Exercise, onChange: @escaping (Exercise) -> Void, onDelete: @escaping (Exercise) -> Void) {
        self.viewModel = ViewModel(for: exercise)
        self.onChange = onChange
        self.onDelete = onDelete
    }
    
    var body: some View {
        List {
            Section {
                HStack {
                    Text("Type")
                    Spacer()
                    ExerciseTypeView(type: viewModel.exercise.type)
                }
                
                HStack {
                    Text("Duration")
                    Spacer()
                    ExerciseDurationView(for: viewModel.exercise)
                        .foregroundColor(.secondary)
                }
            }
            
            if viewModel.exercise.isTypeSet {
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
            ExerciseDetailsView(for: Exercise.catCow, onChange: { _ in }, onDelete: { _ in })
        }
        
        NavigationView {
            ExerciseDetailsView(for: Exercise.vasihsthasana, onChange: { _ in }, onDelete: { _ in })
        }
        
        NavigationView {
            ExerciseDetailsView(for: Exercise.surjaNamascar, onChange: { _ in }, onDelete: { _ in })
        }
    }
}
