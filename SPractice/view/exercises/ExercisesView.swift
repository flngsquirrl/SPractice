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
    @State private var selectedToDelete: IndexSet?
    
    @AppStorage("exercisesSortProperty") internal var sortProperty: SortProperty = .date
    @AppStorage("exercisesSortOrder") internal var sortOrder: SortOrder = .desc

    var body: some View {
        List {
            ForEach(sortedElements) { exercise in
                HStack {
                    NavigationLink {
                        ExerciseDetailsView(for: exercise) { exercises.update($0) }
                    onDelete: { exercises.delete($0) }
                    } label: {
                        ExerciseShortDecorativeView(for: exercise)
                    }
                }
            }
            .onDelete {
                showDeleteConfirmation = true
                selectedToDelete = $0
            }
        }
        .searchable(text: $searchText)
        .disableAutocorrection(true)
        .alert(DeleteAlert.title, isPresented: $showDeleteConfirmation, presenting: selectedToDelete) { indexSet in
            DeleteAlertContent(item: getElementToDelete(index: indexSet.first!)) {
                exercises.delete($0)
            }
        } message: { _ in
            DeleteAlert.messageText
        }
    }
    
    var elements: [ExerciseTemplate] {
        exercises.templates
    }
}

struct ExercisesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ExercisesView()
        }
    }
}
