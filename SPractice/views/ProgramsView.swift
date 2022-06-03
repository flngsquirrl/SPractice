//
//  ProgramsView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 4.05.22.
//

import SwiftUI

struct ProgramsView: View {
    
    @State private var templates = [ProgramTemplate.personal, ProgramTemplate.dailyShort, ProgramTemplate.shortForBack]
    @State private var showSettings = false
    
    var body: some View {
        List {
            ForEach(templates) { template in
                HStack {
                    Button() {}
                        label: {
                            Image(systemName: "play.rectangle")
                                .font(.title)
                        }
                        .onTapGesture {
                            // play
                        }
                    
                    NavigationLink {
                        PracticeView(practice: Practice(from: template))
                    } label: {
                        HStack {
                            Text("\(template.name)")
                        }
                    }
                    
                }
            }
            .onDelete(perform: removeItems)
            .onMove(perform: moveItems)
        }
        .sheet(isPresented: $showSettings) {
            SettingsView()
        }
        .navigationTitle("Programs")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button() {
                    print("Setting")
                    showSettings = true
                } label: {
                    Image(systemName: "gearshape")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button() {
                    // todo open add new program
                } label: {
                    Image(systemName: "plus.circle")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton() //{
                    
//                } label: {
//                    Image(systemName: "pencil.circle.fill")
//                }
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        templates.remove(atOffsets: offsets)
    }
    
    func moveItems(from fromOffsets: IndexSet, to toOffsets: Int) {
        templates.move(fromOffsets: fromOffsets, toOffset: toOffsets)
    }
}

struct ProgramsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProgramsView()
        }
    }
}
