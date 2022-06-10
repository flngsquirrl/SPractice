//
//  AddExerciseTemplateView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 10.06.22.
//

import SwiftUI

struct AddExerciseTemplateView: View {
    
    var onAdd: (ExerciseTemplate) -> Void
    
    var body: some View {
        NavigationView {
            ExerciseTemplateView() { onAdd($0) }
        }
        .accentColor(.customAccentColor)
    }
}

struct AddExerciseTemplateView_Previews: PreviewProvider {
    static var previews: some View {
        AddExerciseTemplateView() { _ in }
    }
}
