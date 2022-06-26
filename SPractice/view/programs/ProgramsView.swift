//
//  ProgramsView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 4.05.22.
//

import SwiftUI

struct ProgramsView: View, EditableView {
    
    @Environment(\.editMode) var editMode
    
    @ObservedObject var programsManager = ProgramsManager.shared
    
    var body: some View {
        List {
            ForEach(programsManager.filteredPrograms) { program in
                HStack {
                    if isInEditMode {
                        Text("\(program.name)")
                            .fontWeight(.semibold)
                    } else {
                        NavigationLink {
                            ProgramDetailsView(for: program) {
                                programsManager.update(program: $0)
                            } onDelete: {
                                programsManager.delete(program: $0)
                            }
                        } label: {
                            VStack(alignment: .leading) {
                                Text("\(program.name)")
                                    .fontWeight(.semibold)
                                Text("\(program.exercises.count) exercises")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
            .onDelete { programsManager.removeItems(at: $0) }
            .onMove { programsManager.moveItems(from: $0, to: $1) }
        }
        .searchable(text: $programsManager.searchText)
        .disableAutocorrection(true)
    }
}

struct ProgramsView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            ProgramsView()
        }
    }
}
