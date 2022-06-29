//
//  ProgramsView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 4.05.22.
//

import SwiftUI

struct ProgramsView: View {
    
    @ObservedObject var programs = Programs.shared
    @State private var searchText = ""
    
    var body: some View {
        List {
            ForEach(sortedPrograms) { program in
                HStack {
                    NavigationLink {
                        ProgramDetailsView(for: program) {
                            programs.update($0)
                        } onDelete: {
                            programs.delete($0)
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
            .onDelete { programs.removeItems(at: $0) }
        }
        .searchable(text: $searchText)
        .disableAutocorrection(true)
    }
    
    var filteredPrograms: [ProgramTemplate] {
        if searchText.isEmpty {
            return programs.templates
        } else {
            return programs.templates.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
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
