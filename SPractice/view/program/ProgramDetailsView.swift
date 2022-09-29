//
//  ProgramDetailsView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 4.06.22.
//

import Survicate
import SwiftUI

struct ProgramDetailsView: View {

    private var program: ProgramTemplate
    private var onChange: (ProgramTemplate) -> Void
    private var onDelete: (ProgramTemplate) -> Void

    @State private var showEditTemplateView = false

    init(for program: ProgramTemplate, onChange: @escaping (ProgramTemplate) -> Void, onDelete: @escaping (ProgramTemplate) -> Void) {
        self.program = program
        self.onChange = onChange
        self.onDelete = onDelete
    }

    var body: some View {
        List {
            ProgramCardView(program: program)
            ProgramPracticeSection(program: program)
            ProgramSummaryView(program: program)
        }
        .onAppear {
            SurvicateSdk.shared.enterScreen(value: "programDetails")
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
}

struct ProgramDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProgramDetailsView(for: .simpleYoga) { _ in } onDelete: { _ in }
        }
    }
}
