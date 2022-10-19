//
//  ProgramDetailsView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 4.06.22.
//

import SwiftUI

struct ProgramDetailsView: View, UpdateProcessor, DeleteProcessor {

    private var program: ProgramTemplate
    var onUpdate: ((ProgramTemplate) -> Void)?
    var onDelete: ((ProgramTemplate) -> Void)?

    @State private var showEditTemplateView = false

    init(for program: ProgramTemplate) {
        self.program = program
    }

    var body: some View {
        NavigationStack {
            List {
                ProgramCardView(program: program)
                ProgramPracticeSection(program: program)
                ProgramSummaryView(program: program)
            }
            .listStyle(.insetGrouped)
            .sheet(isPresented: $showEditTemplateView) {
                NavigationStack {
                    EditProgramView(for: program, onSave: onUpdate ?? { _ in })
                }
                .accentColor(.customAccentColor)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    DeleteToolbarButton(item: program) {
                        onDelete?($0)
                    }

                    Button("Edit") {
                        showEditTemplateView = true
                    }
                }
            }
        }
        .navigationDestination(for: ExerciseTemplate.self) { exercise in
            ExerciseContentsView(exercise: exercise)
        }
    }
}

struct ProgramDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProgramDetailsView(for: .simpleYoga)
        }
    }
}
