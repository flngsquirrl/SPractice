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
    
    private var displayNonTimerDuration = false
    
    init(for exercise: Exercise) {
        self.init(name: exercise.name, type: exercise.type, duration: exercise.duration)
        displayNonTimerDuration = true
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
            if shouldDisplayDuration() {
                switch type {
                case .flow:
                    Image(systemName: "infinity")
                        .foregroundColor(.gray)
                case .timer, .tabata:
                    Text(ClockTime.getShortDisplayDuration(for: duration!))
                        .foregroundColor(.gray)
                }
            }
        }
    }
    
    func shouldDisplayDuration() -> Bool {
        type != .timer && displayNonTimerDuration || type == .timer && duration != nil
    }
}

struct ExerciseDetailsShortView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            Text("exercises")
            ExerciseDetailsShortView(for: Exercise.catCow)
            ExerciseDetailsShortView(for: Exercise.surjaNamascar)
            ExerciseDetailsShortView(for: Exercise.vasihsthasana)
            
            Text("templates")
            ExerciseDetailsShortView(for: ExerciseTemplate.catCowNoDuration)
            ExerciseDetailsShortView(for: ExerciseTemplate.catCow)
            ExerciseDetailsShortView(for: ExerciseTemplate.surjaNamascar)
            ExerciseDetailsShortView(for: ExerciseTemplate.vasihsthasana)
        }
    }
}
