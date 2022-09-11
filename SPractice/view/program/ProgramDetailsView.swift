//
//  ProgramTemplateDetailsView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 4.06.22.
//

import SwiftUI

struct ProgramDetailsView: DetailsView {

    @ObservedObject var programs = Programs.shared

    @State private var showPracticeView = false
    @State private var showEditTemplateView = false
    @State private var showPracticeSettings = false

    @Environment(\.horizontalSizeClass) var sizeClass

    private var program: ProgramTemplate
    private var onChange: (ProgramTemplate) -> Void
    private var onDelete: (ProgramTemplate) -> Void

    init(for program: ProgramTemplate, onChange: @escaping (ProgramTemplate) -> Void, onDelete: @escaping (ProgramTemplate) -> Void) {
        self.program = program
        self.onChange = onChange
        self.onDelete = onDelete
    }

    var isDeleted: Bool {
        !programs.contains(program)
    }

    var detailsContent: some View {
        List {
            ProgramCardView(program: program)

            let isPracticeDisabled = isPracticeDisabled()
            Section {
                Button {
                    showPracticeView = true
                } label: {
                    Label("Run", systemImage: "play.rectangle.fill")
                }
                .disabled(isPracticeDisabled)
                .fullScreenCover(isPresented: $showPracticeView) {
                    PracticeView(for: program)
                }

                Button {
                    showPracticeSettings = true
                } label: {
                    Label("Configure", systemImage: "slider.horizontal.3")
                }
                .sheet(isPresented: $showPracticeSettings) {
                    PracticeSettingsView(for: program)
                }
            } header: {
                Text("Practice")
            } footer: {
                if isPracticeDisabled {
                    Text("Type and duration should be defined for all the exercises to start the practice")
                }
            }
            .rowLeadingAligned()

            ProgramSummaryView(program: program)
        }
        .listStyle(.insetGrouped)
        .sheet(isPresented: $showEditTemplateView) {
            NavigationStack {
                EditProgramView(for: program, onSave: onChange)
            }
            .accentColor(.customAccentColor)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                DeleteToolbarButton(item: program) {
                    onDelete($0)
                }

                Button("Edit") {
                    showEditTemplateView = true
                }
            }
        }
    }

    func isPracticeDisabled() -> Bool {
        !ValidationService.isValidToPractice(template: program)
    }

}

struct ProgramDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProgramDetailsView(for: .simpleYoga) { _ in } onDelete: { _ in }
        }
    }
}
