//
//  ProgramsView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 4.05.22.
//

import SwiftUI

struct ProgramsView: View {
    
    @State private var programs = ["Personal", "Daily short", "Short for back"]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(programs, id: \.self) { program in
                    HStack {
                        Button() {
                            // todo open practice view
                        } label: {
                            Image(systemName: "play.circle")
                        }
                        NavigationLink {
                            PracticeView()
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
            .navigationTitle("Programs")
            .toolbar {
                HStack {
                    Button() {
                        // todo open settings
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
        ProgramsView()
    }
}
