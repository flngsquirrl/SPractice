//
//  ExercisesView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 8.06.22.
//

import SwiftUI

struct ExercisesView: View, EditableView {
    
    @Environment(\.editMode) var editMode
    
    @EnvironmentObject var dataModel: DataModel
    
    var body: some View {
        ForEach(dataModel.exerciseTemplates) { template in
            HStack {
                if isInEditMode {
                    ExerciseDetailsShortView(for: template, displayDuration: template.type == .timer)
                } else {
                    NavigationLink {
                        ExerciseDetailsView(for: template) { dataModel.updateExerciseTemplate(template: $0) }
                            onDelete: { dataModel.deleteExerciseTemplate(template: $0) }
                    } label: {
                        ExerciseDetailsShortView(for: template, displayDuration: template.type == .timer)
                    }
                }
            }
        }
        .onDelete { dataModel.removeExerciseItems(at: $0) }
        .onMove { dataModel.moveExerciseItems(from: $0, to: $1) }
        
    }
}

struct ExercisesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                ExercisesView()
                    .environmentObject(DataModel())
            }
        }
    }
}
