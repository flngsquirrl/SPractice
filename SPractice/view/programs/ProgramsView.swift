//
//  ProgramsView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 4.05.22.
//

import SwiftUI

struct ProgramsView: View {
    
    @ObservedObject var viewModel = ViewModel()
    
    @State private var showSettingsView = false
    @State private var showAddNewProgramView = false
    
    var body: some View {
        Form {
            ForEach(viewModel.templates) { template in
                HStack {
//                    Button() {}
//                        label: {
//                            Image(systemName: "play.rectangle")
//                                .font(.title)
//                        }
//                        .onTapGesture {
//                            // play
//                        }
                    
                    NavigationLink {
                        ProgramDetailsView(for: template) {
                            viewModel.updateProgramTemplate(template: $0)
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
        .sheet(isPresented: $showSettingsView) {
            SettingsView()
        }
        .fullScreenCover(isPresented: $showAddNewProgramView) {
            ProgramTemplateView() { viewModel.addNewProgramTemplate(template: $0) }
        }
        .navigationTitle("Programs")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button() {
                    showSettingsView = true
                } label: {
                    Image(systemName: "gearshape")
                }
            }
//            ToolbarItem(placement: .navigationBarTrailing) {
//                Button() {
//                    showAddNewProgramView = true
//                } label: {
//                    Image(systemName: "plus")
//                }
//            }
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
        }
    }
}

struct ProgramsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProgramsView()
        }
    }
}
