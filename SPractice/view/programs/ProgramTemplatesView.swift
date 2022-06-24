//
//  ProgramTemplatesView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 4.05.22.
//

import SwiftUI

struct ProgramTemplatesView: View, EditableView {
    
    @Environment(\.editMode) var editMode
    
    @ObservedObject var viewModel = ViewModel()

    @State private var showAddNewProgramView = false
    
    var body: some View {
        Group {
            ForEach(viewModel.templates) { template in
                HStack {
                    if isInEditMode {
                        Text("\(template.name)")
                    } else {
                        NavigationLink {
                            ProgramTemplateDetailsView(for: template) {
                                viewModel.updateTemplate(template: $0)
                            } onDelete: {
                                viewModel.deleteTemplate(template: $0)
                            }
                        } label: {
                            Text("\(template.name)")
                        }
                    }
                }
            }
            .onDelete { viewModel.removeItems(at: $0) }
            .onMove { viewModel.moveItems(from: $0, to: $1) }
            
            Section {
                Button() {
                    showAddNewProgramView = true
                } label: {
                    Text("Add new")
                }
                .disabled(isInEditMode)
            }
        }
        .navigationTitle("Programs")
        .sheet(isPresented: $showAddNewProgramView) {
            NavigationView {
                AddProgramTemplateView() { viewModel.addNewTemplate(template: $0) }
            }
            .accentColor(.customAccentColor)
        }
    }
}

struct ProgramsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                ProgramTemplatesView()
            }
        }
    }
}
