//
//  ExerciseTypeView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 23.06.22.
//

import SwiftUI

struct ExerciseTypeView: View {
    
    var type: Exercise.ExerciseType?
    
    var body: some View {
        HStack {
            ExerciseTypeImage(type: type)
            Text(type?.rawValue ?? "not set")
        }
    }
}

struct ExerciseTypeView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseTypeView()
    }
}
