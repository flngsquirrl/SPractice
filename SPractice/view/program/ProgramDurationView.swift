//
//  ProgramDurationView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 1.07.22.
//

import SwiftUI

struct ProgramDurationView: View {

    private let duration: Duration
    private let mode: DurationView.Mode
    private let showAsApproximate: Bool
    
    init(for program: Program, mode: DurationView.Mode = .padded) {
        self.duration = program.duration
        self.mode = mode
        self.showAsApproximate = program.hasFlowExercises
    }
    
    init(for template: ProgramTemplate, mode: DurationView.Mode = .padded) {
        self.duration = template.duration
        self.mode = mode
        self.showAsApproximate = template.hasFlowExercises
    }
    
    init(for duration: Duration, mode: DurationView.Mode = .padded, showAsApproximate: Bool = false) {
        self.duration = duration
        self.mode = mode
        self.showAsApproximate = showAsApproximate
    }
    
    var body: some View {
        switch duration {
        case .known(let time):
            if showAsApproximate {
                LayoutUtils.approximationText
            }
            DurationView(duration: time, mode: mode)
        case .unknown:
            LayoutUtils.unknownDurationImage
        case .unlimited:
            LayoutUtils.unlimitedDurationImage
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
