//
//  ExerciseDetailsShortView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 7.06.22.
//

import SwiftUI

struct ExerciseDetailsShortView: View {
    
    private let name: String
    private let type: Exercise.ExerciseType?
    private let duration: Int?
    private let iconColor: Color
    
    private var displayDuration = false
    
    var isTypeSet: Bool {
        type != nil
    }
    
    init(for exercise: Exercise, iconColor: Color = .primary) {
        self.init(name: exercise.name, type: exercise.type, duration: exercise.duration, iconColor: iconColor)
        displayDuration = true
    }
    
    init(for template: ExerciseTemplate, displayDuration: Bool = false, iconColor: Color = .primary) {
        var duration: Int? = nil
        if (displayDuration) {
            // todo: read from settings here
            duration = template.type == .tabata ? 80 : template.duration
        }
        self.init(name: template.name, type: template.type, duration: duration, iconColor: iconColor)
        
        self.displayDuration = displayDuration
    }
    
    private init(name: String, type: Exercise.ExerciseType?, duration: Int?, iconColor: Color) {
        self.name = name
        self.type = type
        self.duration = duration
        self.iconColor = iconColor
    }
    
    var body: some View {
        HStack {
            ExerciseTypeImage(type: type)
                .foregroundColor(iconColor)
            Text(name)
            Spacer()
            if displayDuration {
                if isTypeSet {
                    switch type! {
                    case .flow:
                        Image(systemName: "infinity")
                            .foregroundColor(.gray)
                    case .timer, .tabata:
                        Text(ClockTime.getPaddedPresentation(for: duration!))
                            .foregroundColor(.gray)
                            .font(.system(.callout).monospacedDigit())
                    }
                } else {
                    Image(systemName: "questionmark")
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

struct ExerciseDetailsShortView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            Group {
                Text("exercises")
                ExerciseDetailsShortView(for: Exercise.catCow)
                ExerciseDetailsShortView(for: Exercise.surjaNamascar)
                ExerciseDetailsShortView(for: Exercise.vasihsthasana, iconColor: .lightOrange)
            }
            
            Group {
                Text("templates with durations")
                ExerciseDetailsShortView(for: ExerciseTemplate.catCowDuration0, displayDuration: true)
                ExerciseDetailsShortView(for: ExerciseTemplate.catCow, displayDuration: true)
                ExerciseDetailsShortView(for: ExerciseTemplate.surjaNamascar, displayDuration: true, iconColor: .lightOrange)
                ExerciseDetailsShortView(for: ExerciseTemplate.vasihsthasana, displayDuration: true)
                ExerciseDetailsShortView(for: ExerciseTemplate.catCowNoType, displayDuration: true, iconColor: .lightOrange)
            }
            
            Group {
                Text("templates without durations")
                ExerciseDetailsShortView(for: ExerciseTemplate.catCowDuration0, iconColor: .lightOrange)
                ExerciseDetailsShortView(for: ExerciseTemplate.catCow)
                ExerciseDetailsShortView(for: ExerciseTemplate.surjaNamascar)
                ExerciseDetailsShortView(for: ExerciseTemplate.vasihsthasana)
                ExerciseDetailsShortView(for: ExerciseTemplate.catCowNoType)
            }
        }
    }
}
