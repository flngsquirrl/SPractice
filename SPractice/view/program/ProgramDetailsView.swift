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
                Group {
                    Toggle("Add rest intervals", isOn: $viewModel.practiceSettings.addRestIntervals.animation())
                    Toggle("Pause after exercise", isOn: $viewModel.practiceSettings.pauseAfterExercise)
                }
                .tint(.customAccentColor)
                .disabled(!viewModel.hasMultipleExercises)
                .onChange(of: viewModel.practiceSettings) { _ in
                    viewModel.updatePracticeSettings()
                }
            } header: {
                Text("Settings")
            } footer: {
                SettingsLinkView(text: "Pauses are added between the exercises, their configuration is based on", settingsSubGroup: .pause)
            }
            
            ProgramSummaryView(program: viewModel.template)
        }
        .fullScreenCover(isPresented: $viewModel.showPracticeView) {
            PracticeView(practice: Practice(for: viewModel.practiceProgram))
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
        .navigationTitle("Program")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                DeleteToolbarButton(item: viewModel.template) {
                    onDelete($0)
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
