//
//  ProgramTemplateDetailsView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 4.06.22.
//

import SwiftUI

struct ProgramDetailsView: DetailsView {

    @ObservedObject private var viewModel: ViewModel

    @ObservedObject var programs = Programs.shared

    @State private var showPracticeView = false
    @State private var showEditTemplateView = false
    @State private var showPracticeSettings = false

    @Environment(\.horizontalSizeClass) var sizeClass

    var onChange: (ProgramTemplate) -> Void
    var onDelete: (ProgramTemplate) -> Void

    init(for program: ProgramTemplate, onChange: @escaping (ProgramTemplate) -> Void, onDelete: @escaping (ProgramTemplate) -> Void) {
        self.viewModel = ViewModel(for: program)
        self.onChange = onChange
        self.onDelete = onDelete
    }

    var isDeleted: Bool {
        !programs.contains(viewModel.template)
    }

    var detailsContent: some View {
        List {
            ProgramCardView(program: viewModel.template)

            Section {
                Button {
                    showPracticeView = true
                } label: {
                    Label("Run", systemImage: "play.rectangle.fill")
                }
                .disabled(viewModel.isPracticeDisabled)
                .fullScreenCover(isPresented: $showPracticeView) {
                    PracticeView(for: viewModel.template)
                }

                Button {
                    showPracticeSettings = true
                } label: {
                    Label("Configure", systemImage: "slider.horizontal.3")
                }
                .sheet(isPresented: $showPracticeSettings) {
                    PracticeSettingsView(for: viewModel.template)
                }
            } header: {
                Text("Practice")
            } footer: {
                if viewModel.isPracticeDisabled {
                    Text("Type and duration should be defined for all the exercises to start the practice")
                }
            }

            ProgramSummaryView(program: viewModel.template)
        }
        .sheet(isPresented: $showEditTemplateView) {
            NavigationView {
                EditProgramView(for: viewModel.template) {
                    viewModel.updateProgramTemplate(template: $0)
                    onChange($0)
                }
            }
            .accentColor(.customAccentColor)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                DeleteToolbarButton(item: viewModel.template) {
                    onDelete($0)
                }

                Button("Edit") {
                    showEditTemplateView = true
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
