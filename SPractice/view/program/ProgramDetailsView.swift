//
//  ProgramTemplateDetailsView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 4.06.22.
//

import SwiftUI

struct ProgramDetailsView: View {
    
    @ObservedObject var viewModel: ViewModel

    var onChange: (ProgramTemplate) -> Void
    var onDelete: (ProgramTemplate) -> Void
    
    init(for program: ProgramTemplate, onChange: @escaping (ProgramTemplate) -> Void, onDelete: @escaping (ProgramTemplate) -> Void) {
        self.viewModel = ViewModel(for: program)
        self.onChange = onChange
        self.onDelete = onDelete
    }
    
    var body: some View {
        List {
            Section {
                Toggle("Use rest", isOn: $viewModel.useRest)
                    .tint(.customAccentColor)
                Button() {
                    viewModel.showPracticeView = true
                } label: {
                    Label("Practice", systemImage: "play.rectangle")
                }
            } header: {
                Text("Practice")
            } footer: {
                Text("Having rest between execises lets you take a deep breath and prepare for the upcoming exercise")
            }
            
            ProgramSummaryView(template: viewModel.programTemplate)
        }
        .fullScreenCover(isPresented: $viewModel.showPracticeView) {
            PracticeView(practice: Practice(for: Program(from: viewModel.programTemplate)))
        }
        .sheet(isPresented: $viewModel.showEditTemplateView) {
            NavigationView {
                EditProgramView(for: viewModel.template) {
                    viewModel.updateProgramTemplate(template: $0)
                    onChange($0)
                }
            }
            .accentColor(.customAccentColor)
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
                    viewModel.showEditTemplateView = true
                }
            }
        }
    }
}

struct ProgramDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProgramDetailsView(for: ProgramTemplate.personal) { _ in } onDelete: { _ in }
        }
    }
}
