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
    
    @State private var showDeleteConfirmation = false
    @State private var selectedToDelete: ProgramTemplate?
    
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
                        ProgramShortDecorativeView(program: program)
                    }
                }
            }
            .onDelete { indexSet in
                showDeleteConfirmation = true
                selectedToDelete = getElementToDelete(index: indexSet.first!)
            }
        }
        .searchable(text: $searchText)
        .disableAutocorrection(true)
        .alert(DeleteAlert.title, isPresented: $showDeleteConfirmation, presenting: selectedToDelete) { item in
            DeleteAlertContent(item: item) {
                programs.delete($0)
            }
        } message: { _ in
            DeleteAlert.messageText
        }
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
