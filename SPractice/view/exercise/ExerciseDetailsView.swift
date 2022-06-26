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
    
    init(for template: Exercise, onChange: @escaping (Exercise) -> Void, onDelete: @escaping (Exercise) -> Void) {
        self.viewModel = ViewModel(for: template)
        self.onChange = onChange
        self.onDelete = onDelete
    }
    
    var body: some View {
        List {
            HStack {
                Text("Type")
                Spacer()
                ExerciseTypeView(type: viewModel.template.type)
            }
            
            if viewModel.template.isTimer {
                HStack {
                    Text("Duration")
                    Spacer()
                    ExerciseDurationView(for: viewModel.template)
                }
            }
            
            if viewModel.template.isTypeSet {
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
        .navigationTitle(viewModel.template.name)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    onDelete(viewModel.template)
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
                EditExerciseView(for: viewModel.template, onSave: onChange)
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
