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
                Image(systemName: "arrow.forward.circle")
                    .foregroundColor(practice.isCompleted ? .secondary : .lightOrange)
                
                if let nextExercise = practice.nextExercise {
                    Text(nextExercise.name)
                        .truncated()
                } else {
                    Text("finish")
                }
                Spacer()
            }
            .foregroundColor(.secondary)
            .wrapped()
            .onTapGesture {
                if !practice.isCompleted {
                    practice.moveToNextExercise()
                }
            }
            
            HStack {
                Text("remaining time")
                Spacer()
                ProgramDurationView(for: practice.durationRemaining, showAsApproximate: practice.isDurationRemainingApproximate)
            }
            .foregroundColor(.secondary)
            .wrapped()
        }
    }
}

struct PracticeSequenceView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PracticeSequenceView(practice: Practice(for: PracticeProgram(for: ProgramTemplate.personal)))
                .frame(width: 320)
        }
    }
}
