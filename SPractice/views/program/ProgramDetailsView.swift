//
//  ProgramDetailsView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 4.06.22.
//

import SwiftUI

struct ProgramDetailsView: View {
    
    @ObservedObject var viewModel: ViewModel
    
    private var onSave: (ProgramTemplate) -> Void
    
    init(for template: ProgramTemplate, onSave: @escaping (ProgramTemplate) -> Void) {
        self.viewModel = ViewModel(for: template)
        self.onSave = onSave
    }
    
    var body: some View {
        List {
            Section("Practice") {
                HStack {
                    Text("Time (min):")
                    Spacer()
                    Text(viewModel.program.wrappedDuration)
                }
                Button("Practice") {
                    viewModel.showPracticeView = true
                }
            }
            
            Section("Exercises") {
                ForEach(viewModel.program.exercises) { exercise in
                    HStack {
                        Image(systemName: exercise.type.imageName)
                        Text(exercise.name)
                        Spacer()
                        Text(exercise.wrappedDuration)
                    }
                }
            }
        }
        .sheet(isPresented: $viewModel.showPracticeView) {
            PracticeView(practice: Practice(for: viewModel.program))
        }
        .fullScreenCover(isPresented: $viewModel.showEditTemplateView) {
            ProgramTemplateView(for: viewModel.template) {               viewModel.updateProgramTemplate(template: $0)
                onSave($0)
            }
        }
        .navigationTitle(viewModel.program.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Edit") {
                    viewModel.showEditTemplateView = true
                }
            }
        }
    }
}

struct ProgramDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ProgramDetailsView(for: ProgramTemplate.personal) { _ in }
    }
}
