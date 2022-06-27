//
//  ProgramTemplateDetailsView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 4.06.22.
//

import SwiftUI

struct ProgramDetailsView: View {
    
    @ObservedObject var viewModel: ViewModel

    var onChange: (Program) -> Void
    var onDelete: (Program) -> Void
    
    init(for program: Program, onChange: @escaping (Program) -> Void, onDelete: @escaping (Program) -> Void) {
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
            
            Section {
                HStack {
                    Text("Duration")
                    Spacer()
                    Text(ClockTime.getExtendedPresentation(for: viewModel.practice.duration!))
                }
            } header: {
                Text("Summary")
            } footer: {
                Text("Duration is the minimal time needed to complete all timer and tabata exercises of the practice, as flow exercises time can't be predicted")
            }
            
            Section("Sequence") {
                ForEach(viewModel.practice.exercises) { exercise in
                    ExerciseShortView(for: exercise)
                }
            }
        }
        .fullScreenCover(isPresented: $viewModel.showPracticeView) {
            PracticeView(practice: Practice(for: viewModel.practice))
        }
        .fullScreenCover(isPresented: $viewModel.showEditTemplateView) {
            NavigationView {
                EditProgramView(for: viewModel.program) {
                    viewModel.updateProgramTemplate(template: $0)
                    onChange($0)
                }
            }
            .accentColor(.customAccentColor)
        }
        .navigationTitle(viewModel.practice.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    onDelete(viewModel.program)
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
            ProgramDetailsView(for: Program.personal) { _ in } onDelete: { _ in }
        }
    }
}
