//
//  ProgramsView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 4.05.22.
//

import SwiftUI

struct ProgramsView: View {
    
    @State private var programs = ["Personal", "Daily short", "Short for back"]
    @State private var showSettings = false
    
    var body: some View {
        List {
            ForEach(programs, id: \.self) { program in
                HStack {
                    Button() {
                        
                    } label: {
                        Image(systemName: "play.rectangle")
                            .font(.title)
                    }
                    .onTapGesture {
                        // todo: play practice
                    }
                    NavigationLink {
                        PracticeView(practice: Practice(for: Program.personal))
                    } label: {
                        HStack {
                            Text("\(program)")
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
            HStack {
                Button() {
                    showSettings = true
                } label: {
                    Image(systemName: "gearshape.fill")
                }
                
                Spacer()
                
                Button("Add") {
                    // todo open add new program
                }
                
                EditButton()
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        programs.remove(atOffsets: offsets)
    }
    
    func moveItems(from fromOffsets: IndexSet, to toOffsets: Int) {
        programs.move(fromOffsets: fromOffsets, toOffset: toOffsets)
    }
}

struct ProgramsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProgramsView()
        }
    }
}
