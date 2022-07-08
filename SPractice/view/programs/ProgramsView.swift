//
//  ProgramsView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 4.05.22.
//

import SwiftUI

struct ProgramsView: View, ManagedList {
    
    typealias Element = ProgramTemplate
    
    @ObservedObject var programs = Programs.shared
    @State internal var searchText = ""
    
    @AppStorage("programsSortType") internal var sortProperty: SortProperty = .date
    @AppStorage("programsSortOrder") internal var sortOrder: SortOrder = .desc
    
    var body: some View {
        List {
            ForEach(sortedElements) { program in
                HStack {
                    NavigationLink {
                        ProgramDetailsView(for: program) {
                            programs.update($0)
                        } onDelete: {
                            programs.delete($0)
                        }
                    } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("\(program.name)")
                                    .fontWeight(.semibold)
                                Group {
                                    Text("\(program.exercises.count) ") +
                                    Text(program.exercises.count == 1 ? "exercise" : "exercises")
                                }
                                .foregroundColor(.secondary)
                            }
                            Spacer()
                            ProgramDurationView(for: program)
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
    
    var elements: [ProgramTemplate] {
        programs.templates
    }
}

struct ProgramsView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            ProgramsView()
        }
    }
}
