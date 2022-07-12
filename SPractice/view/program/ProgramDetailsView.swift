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
    @State private var showSettings = false
    
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
            Section {
                Toggle("Add pauses", isOn: $viewModel.template.usePauses)
                    .onChange(of: viewModel.template.usePauses) { _ in
                        onChange(viewModel.template)
                    }
                    .tint(.customAccentColor)
                    .disabled(viewModel.isusePausesDisabled)
            } header: {
                Text("Settings")
            } footer: {
                HStack(spacing: 0) {
                    Text("Pauses configuration is based on the general ") + 
                    Text("Settings")
                        .foregroundColor(.customAccentColor)
                }.onTapGesture {
                    showSettings = true
                }
            }
            
            Section {
                Button() {
                    viewModel.showPracticeView = true
                } label: {
                    Label("Practice", systemImage: "play.rectangle")
                }
                .disabled(viewModel.isPracticeDisabled)
            } footer: {
                if viewModel.isPracticeDisabled {
                    Text("Type and duration should be defined for all the exercises to start the practice. Please, review the exercises marked with red.")
                }
            }
            
            ProgramSummaryView(program: viewModel.preparedProgram)
        }
        .sheet(isPresented: $showSettings) {
            SettingsSubgroupView(subgroup: .pause)
        }
        .fullScreenCover(isPresented: $viewModel.showPracticeView) {
            PracticeView(practice: Practice(for: PracticeProgram(from: viewModel.preparedProgram)))
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
        .alert(DeleteAlert.title, isPresented: $showDeleteConfirmation) {
            DeleteAlertContent(item: viewModel.template) {
                onDelete($0)
            }
        } message: {
            DeleteAlert.messageText
        }
        .navigationTitle(viewModel.template.name)
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
