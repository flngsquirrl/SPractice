//
//  ExercisesView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 8.06.22.
//

import SwiftUI

struct ExercisesView: View, ManagedList {
    
    typealias Element = ExerciseTemplate
    
    @ObservedObject var exercises = Exercises.shared
    @State internal var searchText = ""
    
    @State private var showDeleteConfirmation = false
    @State private var selectedToDelete: ExerciseTemplate?
    
    @AppStorage("exercisesSortProperty") internal var sortProperty: SortProperty = .date
    @AppStorage("exercisesSortOrder") internal var sortOrder: SortOrder = .desc

    var body: some View {
        List {
            Section {
                ForEach(sortedElements) { exercise in
                    HStack {
                        NavigationLink(tag: exercise.id, selection: $exercises.selection) {
                            ExerciseDetailsView(for: exercise) {
                                exercises.update($0)
                                
                            } onDelete: { exercises.delete($0) }
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
                exercises.delete($0)
            }
        } message: { _ in
            DeleteAlertConstants.messageText
        }
    }
    
    var elements: [ExerciseTemplate] {
        exercises.items
    }
}

struct ExercisesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ExercisesView()
        }
    }
}
