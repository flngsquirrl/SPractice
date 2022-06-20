//
//  ProgramTemplateDetailsView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 4.06.22.
//

import SwiftUI

struct ProgramTemplateDetailsView: View {
    
    @ObservedObject var viewModel: ViewModel

    var onChange: (ProgramTemplate) -> Void
    var onDelete: (ProgramTemplate) -> Void
    
    init(for template: ProgramTemplate, onChange: @escaping (ProgramTemplate) -> Void, onDelete: @escaping (ProgramTemplate) -> Void) {
        self.viewModel = ViewModel(for: template)
        self.onChange = onChange
        self.onDelete = onDelete
    }
    
    var body: some View {
        List {
            Section{
                HStack {
                    Text("Duration")
                    Spacer()
                    Text(ClockTime.getExtendedPresentation(for: viewModel.program.duration!))
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
        .fullScreenCover(isPresented: $viewModel.showPracticeView) {
            PracticeView(practice: Practice(for: viewModel.program))
        }
        .fullScreenCover(isPresented: $viewModel.showEditTemplateView) {
            NavigationView {
                EditProgramTemplateView(for: viewModel.template) {
                    viewModel.updateProgramTemplate(template: $0)
                    onChange($0)
                }
            }
            .accentColor(.customAccentColor)
        }
        .navigationTitle(viewModel.program.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    onDelete(viewModel.template)
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
            ProgramTemplateDetailsView(for: ProgramTemplate.personal) { _ in } onDelete: { _ in }
        }
    }
}
