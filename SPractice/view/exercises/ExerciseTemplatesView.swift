//
//  ExerciseTemplatesView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 8.06.22.
//

import SwiftUI

struct ExerciseTemplatesView: View, EditableView {
    
    @Environment(\.editMode) var editMode
    
    @StateObject var viewModel = ViewModel()
    @State private var showAddNewView = false
    
    var body: some View {
        Group {
            ForEach(viewModel.templates) { template in
                HStack {
                    if isInEditMode {
                        ExerciseDetailsShortView(for: template, displayDuration: template.type == .timer)
                    } else {
                        NavigationLink {
                            ExerciseTemplateDetailsView(template: template) { viewModel.updateTemplate(template: $0) }
                                onDelete: { _ in }
                        } label: {
                            ExerciseDetailsShortView(for: template, displayDuration: template.type == .timer)
                        }
                    }
                }
            }
            .onDelete { viewModel.removeItems(at: $0) }
            .onMove { viewModel.moveItems(from: $0, to: $1) }
            
            Section {
                Button() {
                    showAddNewView = true
                } label: {
                    Text("Add new")
                }
                .disabled(isInEditMode)
            }
        }
        .sheet(isPresented: $showAddNewView) {
            NavigationView {
                AddExerciseTemplateView() { viewModel.addNewTemplate(template: $0) }
            }
            .accentColor(.customAccentColor)
        }
    }
}

struct ExerciseTemplatesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                ExerciseTemplatesView()
            }
        }
    }
}
