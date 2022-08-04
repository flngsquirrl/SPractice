//
//  ProgramsView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 4.05.22.
//

import SwiftUI

struct ProgramsView: View, MainListView, ManagedList {
    
    typealias Element = ProgramTemplate
    
    @ObservedObject var dataManager = Programs.shared
    @ObservedObject var selectionManager = ProgramSelectionManager.shared
    @Environment(\.horizontalSizeClass) var sizeClass
   
    @State internal var searchText = ""
    @AppStorage("programsSortProperty") internal var sortProperty: SortProperty = .date
    @AppStorage("programsSortOrder") internal var sortOrder: SortOrder = .desc
   
    @State private var showDeleteConfirmation = false
    @State private var selectedToDelete: ProgramTemplate?
   
    @State private var showAddNewView = false
   
    var body: some View {
       NavigationView {
           list
           .navigationTitle("Programs")
           .sheet(isPresented: $showAddNewView) {
               addItemView
           }
           .toolbar {
               listToolbar
           }
           
           secondaryView
       }
       .accentColor(.customAccentColor)
    }
   
    var list: some View {
       ScrollViewReader { proxy in
           List {
               ForEach(sortedElements) { program in
                   HStack {
                       NavigationLink(tag: program.id, selection: $selectionManager.selection) {
                           ProgramDetailsView(for: program) {
                               dataManager.update($0)
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
           .onChange(of: selectionManager.newItem) { _ in
               if selectionManager.newItem != nil {
                   withAnimation {
                       proxy.scrollTo(selectionManager.newItem!, anchor: .center)
                   }
               }
           }
           .alert(DeleteAlertConstants.title, isPresented: $showDeleteConfirmation, presenting: selectedToDelete) { item in
               DeleteAlertContent(item: item) {
                   deleteItem($0)
               }
           } message: { _ in
               DeleteAlertConstants.messageText
           }
       }
    }
   
    var addItemView: some View {
       AddProgramView() {
           addItem($0)
       }
    }
   
    var listToolbar: some ToolbarContent {
        ToolbarItemGroup(placement: .navigationBarTrailing) {
            Button() {
            showAddNewView = true
            } label: {
            Image(systemName: "plus")
               .frame(width: 25)
            }

            SortingMenu(sortProperty: $sortProperty, sortOrder: $sortOrder)
        }
    }
    
    func setSorting(property: SortProperty, order: SortOrder) {
        sortProperty = property
        sortOrder = order
    }
}

struct ProgramsView_Previews: PreviewProvider {
    
    static var previews: some View {
        ProgramsView()
    }
}
