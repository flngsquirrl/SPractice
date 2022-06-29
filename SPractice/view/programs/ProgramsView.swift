//
//  ProgramsView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 4.05.22.
//

import SwiftUI

struct ProgramsView: View {
    
    @ObservedObject var programsManager = ProgramsManager.shared
    
    @State private var searchText = ""
    
    var body: some View {
        List {
            ForEach(sortedPrograms) { program in
                HStack {
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
            .onDelete { programsManager.removeItems(at: $0) }
        }
        .searchable(text: $searchText)
        .disableAutocorrection(true)
    }
    
    var filteredPrograms: [ProgramTemplate] {
        if searchText.isEmpty {
            return programsManager.existingPrograms
        } else {
            return programsManager.existingPrograms.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var sortedPrograms: [ProgramTemplate] {
        let sorted: [ProgramTemplate] = filteredPrograms.reversed()
        return sorted
    }
}

struct ProgramsView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            ProgramsView()
        }
    }
}
