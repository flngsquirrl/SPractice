//
//  ProgramTemplatesView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 4.05.22.
//

import SwiftUI

struct ProgramTemplatesView: View {
    
    @ObservedObject var viewModel = ViewModel()

    @State private var showAddNewProgramView = false
    
    var body: some View {
        Group {
            ForEach(viewModel.templates) { template in
                HStack {                  
                    NavigationLink {
                        ProgramDetailsView(for: template) {
                            viewModel.updateTemplate(template: $0)
                        }
                    } label: {
                        HStack {
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
            }
        }
        .fullScreenCover(isPresented: $showAddNewProgramView) {
            ProgramTemplateView() { viewModel.addNewTemplate(template: $0) }
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