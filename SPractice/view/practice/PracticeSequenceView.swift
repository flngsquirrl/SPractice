//
//  PracticeSequenceView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 10.05.22.
//

import SwiftUI

struct PracticeSequenceView: View {
    
    @ObservedObject var practice: Practice
    
    var body: some View {
        Group {
            HStack {
                Image(systemName: "arrow.forward.circle.fill")
                
                if let nextExercise = practice.nextExercise {
                    ExerciseShortView(for: nextExercise)
                } else {
                    Text("finish")
                    Spacer()
                }
            }
            .foregroundColor(.secondary)
            .wrapped()
            
            HStack {
                Text("Remaining time")
                Spacer()
                // todo implement separate view here like ExerciseDurationView
                Text(ClockTime.getPaddedPresentation(for: practice.durationRemaining!))
                    .font(.system(.callout).monospacedDigit())
            }
            .foregroundColor(.secondary)
            .wrapped()
        }
    }
}

struct PracticeSequenceView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PracticeSequenceView(practice: Practice(for: Program(from: ProgramTemplate.personal)))
                .frame(width: 320)
        }
    }
}
