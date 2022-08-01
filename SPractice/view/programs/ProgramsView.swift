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
    @ObservedObject var programsSelection = ProgramSelectionManager.shared
    
    @State internal var searchText = ""
    
    @State private var showDeleteConfirmation = false
    @State private var selectedToDelete: ProgramTemplate?
    
    @AppStorage("programsSortProperty") internal var sortProperty: SortProperty = .date
    @AppStorage("programsSortOrder") internal var sortOrder: SortOrder = .desc
    
    var body: some View {
        ScrollViewReader { proxy in
            List {
                Section {
                    ForEach(sortedElements) { program in
                        HStack {
                            NavigationLink(tag: program.id, selection: $programsSelection.selection) {
                                ProgramDetailsView(for: program) {
                                    programs.update($0)
                                } onDelete: {
                                    deleteItem($0)
                                }
                            } label: {
                                ProgramShortDecorativeView(for: program, isAccented: program.id == selectedToDelete?.id, accentColor: .customAccentColor)
                            }
                        }
                    }
                    .onDelete { indexSet in
                        showDeleteConfirmation = true
                        selectedToDelete = getSortedElement(index: indexSet.first!)
                    }
                }
            }
            .listStyle(.inset)
            .onChange(of: showDeleteConfirmation) { shouldShow in
                if !shouldShow {
                    withAnimation {
                        selectedToDelete = nil
                    }
                }
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .disableAutocorrection(true)
            .alert(DeleteAlertConstants.title, isPresented: $showDeleteConfirmation, presenting: selectedToDelete) { item in
                DeleteAlertContent(item: item) {
                    deleteItem($0)
                }
            }
            .onChange(of: programsSelection.newItem) { _ in
                if programsSelection.newItem != nil {
                    withAnimation {
                        proxy.scrollTo(programsSelection.newItem!, anchor: .center)
                    }
                }
            }
        }
    }
    
    func deleteItem(_ item: ProgramTemplate) {
        programs.delete(item)
        programsSelection.onItemDelete(id: item.id)
    }
    
    var elements: [ProgramTemplate] {
        programs.items
    }
}

struct ProgramsView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            ProgramsView()
        }
    }
}
