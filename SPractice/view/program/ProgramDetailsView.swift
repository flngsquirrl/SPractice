//
//  ProgramTemplateDetailsView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 4.06.22.
//

import SwiftUI

struct ProgramDetailsView: DetailsView {
    
    @ObservedObject private var viewModel: ViewModel
    
    @State private var showDeleteConfirmation = false
    
    @ObservedObject var programs = Programs.shared
    
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var isDeleted: Bool {
        !programs.contains(viewModel.template)
    }

    var onChange: (ProgramTemplate) -> Void
    var onDelete: (ProgramTemplate) -> Void
    
    init(for program: ProgramTemplate, onChange: @escaping (ProgramTemplate) -> Void, onDelete: @escaping (ProgramTemplate) -> Void) {
        self.viewModel = ViewModel(for: program)
        self.onChange = onChange
        self.onDelete = onDelete
    }
    
    var detailsContent: some View {
        List {
            ProgramCardView(program: viewModel.template)
            
            Section {
                Button() {
                    viewModel.showPracticeView = true
                } label: {
                    HStack {
                        Image(systemName: "play.rectangle.fill")
                            .decorated()
                        Text("Practice")
                    }
                }
                .disabled(viewModel.isPracticeDisabled)
            } footer: {
                if viewModel.isPracticeDisabled {
                    Text("Type and duration should be defined for all the exercises to start the practice")
                }
            }
            
            Section {
                Toggle("Add pauses", isOn: $viewModel.template.usePauses.animation())
                    .onChange(of: viewModel.template.usePauses) { _ in
                        onChange(viewModel.template)
                    }
                    .tint(.customAccentColor)
                    .disabled(viewModel.isUsePausesDisabled)
            } header: {
                Text("Settings")
            } footer: {
                SettingsLinkView(text: "Pauses are added between the exercises, their configuration is based on", settingsSubGroup: .pause)
            }
            
            ProgramSummaryView(program: viewModel.template)
        }
        .fullScreenCover(isPresented: $viewModel.showPracticeView) {
            PracticeView(practice: Practice(for: PracticeProgram(from: viewModel.template)))
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
        .alert(DeleteAlertConstants.title, isPresented: $showDeleteConfirmation) {
            DeleteAlertContent(item: viewModel.template) {
                onDelete($0)
            }
        } message: {
            DeleteAlertConstants.messageText
        }
        .navigationTitle("Program")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    showDeleteConfirmation = true
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
