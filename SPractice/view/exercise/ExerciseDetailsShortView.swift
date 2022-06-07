//
//  ExerciseDetailsShortView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 7.06.22.
//

import SwiftUI

struct ExerciseDetailsShortView: View {
    
    private let name: String
    private let type: Exercise.ExerciseType
    private let duration: Int?
    
    init(for exercise: Exercise) {
        self.init(name: exercise.name, type: exercise.type, duration: exercise.duration)
    }
    
    init(for template: ExerciseTemplate) {
        self.init(name: template.name, type: template.type, duration: template.duration)
    }
    
    init(name: String, type: Exercise.ExerciseType, duration: Int?) {
        self.name = name
        self.type = type
        self.duration = duration
    }
    
    var body: some View {
        HStack {
            Image(systemName: type.imageName)
            Text(name)
            Spacer()
            switch type {
            case .flow:
                Image(systemName: "infinity")
                    .foregroundColor(.gray)
            case .timer:
                Text(ClockTime.getDisplayDuration(for: duration!))
                    .foregroundColor(.gray)
            case .tabata:
                // todo: read settings for tabata
                Text(ClockTime.getDisplayDuration(for: 260))
                    .foregroundColor(.gray)
            }
        }
    }
}

struct ExerciseDetailsShortView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            ExerciseDetailsShortView(for: Exercise.catCow)
            ExerciseDetailsShortView(for: ExerciseTemplate.catCow)
            ExerciseDetailsShortView(for: Exercise.surjaNamascar)
            ExerciseDetailsShortView(for: ExerciseTemplate.surjaNamascar)
            ExerciseDetailsShortView(for: Exercise.vasihsthasana)
            ExerciseDetailsShortView(for: ExerciseTemplate.vasihsthasana)
        }
    }
}
