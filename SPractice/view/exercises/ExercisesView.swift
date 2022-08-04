//
//  ExercisesView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 8.06.22.
//

import SwiftUI

struct ExercisesView: View, MainListView, ManagedList {
    
    typealias Element = ExerciseTemplate
   
    @ObservedObject var dataManager = Exercises.shared
    @ObservedObject var selectionManager = ExerciseSelectionManager.shared
    @Environment(\.horizontalSizeClass) var sizeClass
   
    @State internal var searchText = ""
    @AppStorage("exercisesSortProperty") internal var sortProperty: SortProperty = .date
    @AppStorage("exercisesSortOrder") internal var sortOrder: SortOrder = .desc
   
    @State private var showDeleteConfirmation = false
    @State private var selectedToDelete: ExerciseTemplate?
   
    @State private var showAddNewView = false
   
    var body: some View {
       NavigationView {
           list
           .navigationTitle("Exercises")
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
               ForEach(sortedElements) { exercise in
                   HStack {
                       NavigationLink(tag: exercise.id, selection: $selectionManager.selection) {
                           ExerciseDetailsView(for: exercise) {
                               dataManager.update($0)
                           } onDelete: { deleteItem($0) }
                       } label: {
                           let isAccented = exercise.id == selectedToDelete?.id
                           ExerciseShortDecorativeView(for: exercise, isIconAccented: isAccented, isNameAccented: isAccented, isFilled: true)
                       }
                   }
               }
               .onDelete { indexSet in
                   showDeleteConfirmation = true
                   selectedToDelete = getSortedElement(index: indexSet.first!)
               }
           }
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
       AddExerciseView() {
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
}

struct ExercisesView_Previews: PreviewProvider {
    static var previews: some View {
        ExercisesView()
    }
}
