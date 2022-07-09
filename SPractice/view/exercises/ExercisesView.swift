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
            ForEach(sortedElements) { exercise in
                HStack {
                    NavigationLink {
                        ExerciseDetailsView(for: exercise) {
                            exercises.update($0)
                            
                        } onDelete: { exercises.delete($0) }
                    } label: {
                        ExerciseShortDecorativeView(for: exercise, isIconAccented: exercise.id == selectedToDelete?.id, accentColor: .red, isFilled: true)
                    }
                }
            }
            .onDelete { indexSet in
                showDeleteConfirmation = true
                selectedToDelete = getElementToDelete(index: indexSet.first!)
            }
        }
        .onChange(of: showDeleteConfirmation) { shouldShow in
            if !shouldShow {
                withAnimation {
                    selectedToDelete = nil
                }
            }
        }
        .searchable(text: $searchText)
        .disableAutocorrection(true)
        .alert(DeleteAlert.title, isPresented: $showDeleteConfirmation, presenting: selectedToDelete) { item in
            DeleteAlertContent(item: item) {
                exercises.delete($0)
            }
        } message: { _ in
            DeleteAlert.messageText
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
