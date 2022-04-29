//
//  PracticeView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 29.04.22.
//

import SwiftUI

struct PracticeView: View {
    var body: some View {
        ExerciseView(exercise: Exercise.catCow)
    }
}

struct PracticeView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.orange
                .ignoresSafeArea()
            PracticeView()
        }
    }
}
