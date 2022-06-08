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
            Section{
                HStack {
                    Text("Duration")
                    Spacer()
                    Text(ClockTime.getLongDisplayDuration(for: viewModel.program.duration!))
                }
                Button() {
                    viewModel.showPracticeView = true
                } label: {
                    Label("Practice", systemImage: "play.rectangle")
                }
            } header: {
                Text("Summary")
            } footer: {
                Text("Duration is the minimal time needed to complete all timer and tabata exercises of the practice, as flow exercises time can't be predicted")
            }
            
            Section("Sequence") {
                ForEach(viewModel.program.exercises) { exercise in
                    ExerciseDetailsShortView(for: exercise)
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
                Button {
                    // todo:
                } label: {
                    Image(systemName: "trash")
                }
            }
            
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
        NavigationView {
            ProgramDetailsView(for: ProgramTemplate.personal) { _ in }
        }
    }
}
