//
//  ExerciseTemplateDetailsView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 18.06.22.
//

import SwiftUI

struct ExerciseTemplateDetailsView: View {
    
    @ObservedObject private var viewModel: ViewModel
    
    private var onChange: (ExerciseTemplate) -> Void
    private var onDelete: (ExerciseTemplate) -> Void
    
    @State private var showEditView = false
    
    init(for template: ExerciseTemplate, onChange: @escaping (ExerciseTemplate) -> Void, onDelete: @escaping (ExerciseTemplate) -> Void) {
        self.viewModel = ViewModel(for: template)
        self.onChange = onChange
        self.onDelete = onDelete
    }
    
    var body: some View {
        List {
            HStack {
                Text("Type")
                Spacer()
                
                ExerciseTypeImage(type: viewModel.template.type)
                Text(viewModel.template.type?.rawValue ?? "not set")
            }
            
            if viewModel.template.isTimer {
                HStack {
                    Text("Duration")
                    Spacer()
                    Text(ClockTime.getPaddedPresentation(for: viewModel.template.duration!))
                }
            }
            
            Section {
                ForEach(viewModel.tasks) { task in
                    HStack {
                        TaskTypeImage(type: task.type)
                        
                        Text(task.name)
                        Spacer()
                        
                        Group {
                            if task.duration != nil {
                                Text(ClockTime.getPaddedPresentation(for: task.duration!))
                                    .font(.system(.callout).monospacedDigit())
                            }
                        }
                        .foregroundColor(.gray)
                    }
                }
            } header: {
                Text("Tasks")
            } footer: {
                Text("The details are based on the current settings")
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
                EditExerciseTemplateView(for: viewModel.template, onSave: onChange)
                }
                .accentColor(.customAccentColor)
        }
    }
}

struct ExerciseDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ExerciseTemplateDetailsView(for: ExerciseTemplate.catCow, onChange: { _ in }, onDelete: { _ in })
        }
    }
}
