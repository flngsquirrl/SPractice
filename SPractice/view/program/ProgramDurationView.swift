//
//  ProgramDurationView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 1.07.22.
//

import SwiftUI

struct ProgramDurationView: View {

    private let duration: Int?
    private let hasExercisesMissingDuration: Bool
    private let mode: DurationView.Mode
    
    init(for program: Program, mode: DurationView.Mode = .padded) {
        self.duration = program.duration
        self.hasExercisesMissingDuration = false
        
        self.mode = mode
    }
    
    init(for template: ProgramTemplate, mode: DurationView.Mode = .padded) {
        self.duration = template.duration
        self.hasExercisesMissingDuration = template.hasExercisesMissingDuration
        self.mode = mode
    }
    
    init(for duration: Int?, mode: DurationView.Mode = .padded) {
        self.duration = duration
        self.hasExercisesMissingDuration = false
        self.mode = mode
    }
    
    var body: some View {
        if duration != nil {
            DurationView(duration: duration!, mode: mode)
        } else {
            if hasExercisesMissingDuration {
                Image(systemName: "questionmark")
            } else {
                Image(systemName: "infinity")
            }
        }
    }
}

struct ProgramDurationView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            ProgramDurationView(for: Program.personal, mode: .extended)
            ProgramDurationView(for: Program.personal, mode: .padded)
        }
    }
}
