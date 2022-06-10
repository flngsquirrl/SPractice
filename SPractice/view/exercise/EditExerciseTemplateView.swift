//
//  EditExerciseTemplateView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 10.06.22.
//

import SwiftUI

struct EditExerciseTemplateView: View {
    var template: ExerciseTemplate
    var onSave: (ExerciseTemplate) -> Void
    
    var body: some View {
        ExerciseTemplateView(for: template) { onSave($0) }
    }
}

struct EditExerciseTemplateView_Previews: PreviewProvider {
    static var previews: some View {
        EditExerciseTemplateView(template: ExerciseTemplate.catCow) { _ in }
    }
}
