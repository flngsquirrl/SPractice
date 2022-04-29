//
//  PracticeView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 29.04.22.
//

import SwiftUI

struct PracticeView: View {
    var body: some View {
        VStack {
            Spacer()
            ExerciseView(exercise: Exercise.catCow)
            Spacer()
            PlayerView()
            Spacer()
        }
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
