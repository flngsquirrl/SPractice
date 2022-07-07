//
//  ExercisesView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 8.06.22.
//

import SwiftUI

struct ExercisesView: View {
    
    @ObservedObject var exercises = Exercises.shared
    @State private var searchText = ""

    var body: some View {
        List {
            ForEach(sortedExercises) { exercise in
                HStack {
                    NavigationLink {
                        ExerciseDetailsView(for: exercise) { exercises.update($0) }
                    onDelete: { exercises.delete($0) }
                    } label: {
                        ExerciseShortDecorativeView(for: exercise)
                    }
                }
            }
            .onDelete { exercises.removeItems(at: $0) }
        }
        .searchable(text: $searchText)
        .disableAutocorrection(true)
    }
    
    var filteredExercises: [ExerciseTemplate] {
        if searchText.isEmpty {
            return exercises.templates
        } else {
            return exercises.templates.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var sortedExercises: [ExerciseTemplate] {
        let sorted: [ExerciseTemplate] = filteredExercises.reversed()
        return sorted
    }
}

struct ExercisesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ExercisesView()
        }
    }
}
